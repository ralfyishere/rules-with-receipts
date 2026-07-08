#!/bin/bash
# Trigger eval: do the right skills activate from realistic (messy) prompts?
#
# Protocol (see .claude/learnings/2026-07-07-subagents-inherit-skill-snapshot.md):
# - fresh `claude -p` per cell, in a temp dir OUTSIDE this tree (subagents can't
#   test discovery; they inherit the parent's skill snapshot)
# - quota-stub guard: outputs containing the session-limit text are NOT RUN
# - detection: Skill tool invocations parsed from --output-format stream-json
# - sessions get --allowedTools Skill,Read only: we measure routing, not the
#   task itself, and a "push it" prompt must never be able to actually push
#
# Usage: ./run-trigger-eval.sh [case-id ...]   (default: all)   REPS=n (default 1)
set -u
cd "$(dirname "$0")" || exit 1
PACK_ROOT="$(cd .. && pwd)"
REPS="${REPS:-1}"
STAMP=$(date +%Y%m%d-%H%M%S)
OUT="$(pwd)/results/$STAMP"
mkdir -p "$OUT"
PASSC=0; FAILC=0; NOTRUN=0

CASE_IDS=$(python3 -c 'import json;print(" ".join(c["id"] for c in json.load(open("cases.json"))))')
[ $# -gt 0 ] && CASE_IDS="$*"

for id in $CASE_IDS; do
  for rep in $(seq 1 "$REPS"); do
    read -r prompt < <(python3 -c 'import json,sys
c=[c for c in json.load(open("cases.json")) if c["id"]==sys.argv[1]][0]
print(c["prompt"])' "$id")
    WS=$(mktemp -d "${TMPDIR:-/tmp}/trigeval-$id-r$rep-XXXXXX")
    mkdir -p "$WS/.claude"
    cp -R "$PACK_ROOT/.claude/skills" "$WS/.claude/skills"
    # Install the snippet as the workspace CLAUDE.md (the pack's recommended install)
    awk '/^```markdown$/{f=1;next} /^```$/{f=0} f' "$PACK_ROOT/.claude/skills/CLAUDE-MD-SNIPPET.md" > "$WS/CLAUDE.md"
    printf 'teh quick brown fox\n' > "$WS/README.md"
    LOG="$OUT/$id.r$rep.jsonl"
    ( cd "$WS" && claude -p "$prompt" --max-turns 4 \
        --allowedTools "Skill,Read" --output-format stream-json --verbose \
        > "$LOG" 2>&1 )
    if grep -q "hit your session limit" "$LOG"; then
      echo "NOT RUN (quota stub): $id r$rep"; NOTRUN=$((NOTRUN+1)); rm -rf "$WS"; continue
    fi
    VERDICT=$(python3 - "$id" "$LOG" <<'PYEOF'
import json, sys
cid, log = sys.argv[1], sys.argv[2]
case = [c for c in json.load(open("cases.json")) if c["id"] == cid][0]
invoked = set()
for line in open(log):
    try: ev = json.loads(line)
    except Exception: continue
    for blk in (ev.get("message", {}) or {}).get("content", []) or []:
        if isinstance(blk, dict) and blk.get("type") == "tool_use" and blk.get("name") == "Skill":
            invoked.add((blk.get("input", {}) or {}).get("skill", "?"))
inv = ",".join(sorted(invoked)) or "(none)"
if "expect_any" in case:
    ok = bool(invoked & set(case["expect_any"]))
    print(("PASS" if ok else "FAIL") + f" invoked=[{inv}] expected any of {case['expect_any']}")
else:
    bad = invoked & set(case.get("forbid", []))
    print(("PASS" if not bad else "FAIL") + f" invoked=[{inv}] forbidden hit: {sorted(bad)}")
PYEOF
)
    echo "$id r$rep: $VERDICT" | tee -a "$OUT/RESULTS.txt"
    case "$VERDICT" in PASS*) PASSC=$((PASSC+1));; *) FAILC=$((FAILC+1));; esac
    rm -rf "$WS"
  done
done

echo "== $PASSC pass, $FAILC fail, $NOTRUN not-run (quota) -> results/$STAMP/RESULTS.txt" | tee -a "$OUT/RESULTS.txt"
[ "$FAILC" = "0" ]
