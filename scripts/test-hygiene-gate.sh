#!/bin/bash
# Unit test for hygiene-gate.sh. Cases live in-file; expected outcome per line.
# Format: EXPECTED_EXIT<TAB>COMMAND
cd "$(dirname "$0")/.." || exit 1
export CLAUDE_PROJECT_DIR="$PWD"
MARKER=.claude/.hygiene-gate-pass
PASS=0; FAIL=0
# The test manipulates the real marker; preserve any live gate state.
# Restore via os.utime (raw epoch, timezone-free): touch -t is local-time
# formatted and skewed the restored mtime by the UTC offset.
SAVED=""
[ -f "$MARKER" ] && SAVED=$(python3 -c 'import os,sys;print(int(os.path.getmtime(sys.argv[1])))' "$MARKER")
restore_marker() {
  rm -f "$MARKER"
  [ -n "$SAVED" ] && python3 - "$MARKER" "$SAVED" <<'PYEOF'
import os, sys
open(sys.argv[1], "a").close()
t = int(sys.argv[2]); os.utime(sys.argv[1], (t, t))
PYEOF
}
trap restore_marker EXIT

run_case() { # $1=expected exit, $2=command
  printf '{"tool_input":{"command":%s}}' "$(python3 -c 'import json,sys;print(json.dumps(sys.argv[1]))' "$2")" \
    | ./scripts/hygiene-gate.sh >/dev/null 2>&1
  got=$?
  if [ "$got" = "$1" ]; then PASS=$((PASS+1)); echo "  ok   [$got] $2"
  else FAIL=$((FAIL+1)); echo "  FAIL [want $1 got $got] $2"; fi
}

echo "== no marker: benign must pass (0), risky must block (2) =="
rm -f "$MARKER"
while IFS=$'\t' read -r exp cmd; do run_case "$exp" "$cmd"; done <<'CASES'
0	git status
0	git add -A && git commit -m "local work"
0	git log --oneline
0	ls -la && grep -r pattern .
0	./scripts/check-pack.sh
0	git add trigger-eval/results/x/t03-push-it.r1.jsonl
0	git check-ignore -v trigger-eval/results/x/t03-push-it.r1.jsonl
2	git push origin main
2	git push -f origin main
2	cd /somewhere && git push
2	gh release create v1.4.0 --notes "x"
2	gh repo edit some-owner/x --visibility public
2	gh repo create newrepo --public
2	npm publish
2	twine upload dist/*
2	gh pr create --title x
2	gh api -X PATCH repos/o/r -f visibility=public
CASES

echo "== fresh marker: risky must pass (0) =="
touch "$MARKER"
while IFS=$'\t' read -r exp cmd; do run_case "$exp" "$cmd"; done <<'CASES'
0	git push origin main
0	gh release create v1.4.0
CASES

echo "== expired marker (65 min old): risky must block (2) =="
touch -t "$(date -v-65M +%Y%m%d%H%M 2>/dev/null || date -d '-65 minutes' +%Y%m%d%H%M)" "$MARKER"
while IFS=$'\t' read -r exp cmd; do run_case "$exp" "$cmd"; done <<'CASES'
2	git push origin main
CASES

echo "RESULT: $PASS passed, $FAIL failed"
[ "$FAIL" = "0" ]
