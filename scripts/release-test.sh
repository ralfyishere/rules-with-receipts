#!/bin/bash
# Cold-start release test (RELEASE-CHECKLIST items 4, 9, 10, 11).
# Installs the pack from a given source tree into a fresh temp git repo and
# verifies BEHAVIOR with captured exit codes — not just file presence.
# Usage: release-test.sh /path/to/pack-source   (typically a fresh public clone)
set -u
SRC="${1:?usage: release-test.sh /path/to/pack-source}"
SRC="$(cd "$SRC" && pwd)"
FAILS=0
ok()  { echo "  ok   $*"; }
bad() { echo "  FAIL $*"; FAILS=$((FAILS+1)); }
check_eq() { [ "$2" = "$3" ] && ok "$1 ($2)" || bad "$1 (got '$2', want '$3')"; }

T=$(mktemp -d "${TMPDIR:-/tmp}/qp-reltest-XXXXXX")
trap 'rm -rf "$T"' EXIT
cd "$T" && git init -q && git config user.email release-test@example.invalid \
  && git config user.name "Release Test" && echo "# app" > README.md \
  && git add -A && git commit -qm init

echo "== release test: fresh install from $SRC =="
"$SRC/install-pack.sh" "$T" >/dev/null 2>&1
check_eq "installer exit" "$?" "0"

SRC_SKILLS=$(ls -d "$SRC"/.claude/skills/*/ | wc -l | tr -d ' ')
TGT_SKILLS=$(ls -d "$T"/.claude/skills/*/ | wc -l | tr -d ' ')
check_eq "skills installed = shipped" "$TGT_SKILLS" "$SRC_SKILLS"

SRC_RULES=$(awk '/^```markdown$/{f=1;next} /^```$/{f=0} f' "$SRC/.claude/skills/CLAUDE-MD-SNIPPET.md" | grep -c '^- ')
TGT_RULES=$(awk '/quality-pack:snippet:BEGIN/{f=1} /quality-pack:snippet:END/{f=0} f' "$T/CLAUDE.md" | grep -c '^- ')
check_eq "CLAUDE.md snippet rules = shipped" "$TGT_RULES" "$SRC_RULES"

grep -q hygiene-gate "$T/.claude/settings.json" && ok "Claude hook wired" || bad "Claude hook missing"
check_eq "git core.hooksPath" "$(cd "$T" && git config core.hooksPath)" ".githooks"

cd "$T"
printf '{"tool_input":{"command":"git push origin main"}}' \
  | CLAUDE_PROJECT_DIR="$T" ./scripts/hygiene-gate.sh >/dev/null 2>&1
check_eq "gate blocks risky command before scan" "$?" "2"
./scripts/security-scan.sh >/dev/null 2>&1
check_eq "security scan (opens gate)" "$?" "0"
printf '{"tool_input":{"command":"git push origin main"}}' \
  | CLAUDE_PROJECT_DIR="$T" ./scripts/hygiene-gate.sh >/dev/null 2>&1
check_eq "gate passes after scan" "$?" "0"

GATE=$(./scripts/test-hygiene-gate.sh 2>/dev/null | tail -1)
case "$GATE" in *", 0 failed") ok "gate unit tests ($GATE)";; *) bad "gate unit tests ($GATE)";; esac
./scripts/check-pack.sh >/dev/null 2>&1;      check_eq "check-pack (installed mode)" "$?" "0"
./scripts/closeout-check.sh >/dev/null 2>&1;  check_eq "closeout-check (installed mode)" "$?" "0"

echo "== upgrade preservation =="
echo "FILLED CONTEXT" > claude-context/business-summary.md
mkdir -p .claude/skills/zz-project-skill && echo "custom" > .claude/skills/zz-project-skill/SKILL.md
printf '\n## project notes\nkeep me\n' >> CLAUDE.md
"$SRC/install-pack.sh" --upgrade "$T" >/dev/null 2>&1
check_eq "upgrade exit" "$?" "0"
check_eq "context preserved" "$(cat claude-context/business-summary.md)" "FILLED CONTEXT"
[ -e .claude/skills/zz-project-skill/SKILL.md ] && ok "custom skill preserved" || bad "custom skill lost"
grep -q "keep me" CLAUDE.md && ok "CLAUDE.md notes outside markers preserved" || bad "CLAUDE.md notes lost"

echo "== portability grep of installed tree =="
ME="$(whoami)"; HN="$(hostname -s 2>/dev/null || echo NOHOST)"
HITS=$(grep -rIilE "/Users/[a-z][a-z]+/|/home/[a-z][a-z]+/|$ME|$HN" . --exclude-dir=.git \
       --exclude='security-scan*.sh' --exclude='hygiene-gate.sh' 2>/dev/null | head -3 || true)
[ -z "$HITS" ] && ok "no machine/user strings installed" || { bad "machine strings found:"; echo "$HITS"; }

echo
if [ "$FAILS" = "0" ]; then echo "RELEASE TEST: PASS"; else echo "RELEASE TEST: $FAILS FAILURE(S)"; exit 1; fi
