#!/bin/bash
# PreToolUse hook: deterministic publish-hygiene gate.
# Blocks public-boundary Bash commands (push, release, publish, visibility
# change) unless scripts/security-scan.sh has passed recently.
#
# Why this exists: skill activation is judgment, and judgment fails exactly
# when prompts are oblique ("push it"). This hook does not depend on judgment.
# See .claude/skills/publish-hygiene/ for the full procedure.
#
# Wire-up (.claude/settings.json): PreToolUse matcher "Bash" -> this script.
# Input: hook JSON on stdin (.tool_input.command). Exit 0 = allow, exit 2 =
# block (stderr is shown to the model). Marker: .claude/.hygiene-gate-pass,
# written by security-scan.sh on a clean run, valid for MARKER_TTL_MIN.
# Escape hatch (user-initiated only): touch .claude/.hygiene-gate-pass

set -u
MARKER="${CLAUDE_PROJECT_DIR:-.}/.claude/.hygiene-gate-pass"
MARKER_TTL_MIN="${HYGIENE_GATE_TTL_MIN:-60}"

CMD=$(python3 -c 'import json,sys
try: print(json.load(sys.stdin).get("tool_input",{}).get("command",""))
except Exception: print("")' 2>/dev/null)

# Public-boundary commands. Deliberately narrow: everyday git (status, add,
# commit, diff) never matches; only crossings of the machine boundary do.
# "push" must stand alone (hyphenated tokens like a t03-push-it filename
# don't count); quoted "git push" in prose still blocks — over-blocking is
# the chosen failure direction for a safety gate.
RISKY='(git[^|;&]*[^-[:alnum:]]push([^-[:alnum:]]|$)|gh (release|pr) create|gh release (edit|upload)|gh repo create|gh repo edit[^|;&]*(visibility|--public)|gh api[^|;&]*-X (PATCH|POST|PUT)[^|;&]*(repos|visibility)|npm publish|twine upload|pipx? +upload|flit publish|hatch publish|cargo publish|gem[^|;&]*[^-[:alnum:]]push([^-[:alnum:]]|$))'

echo "$CMD" | grep -qiE "$RISKY" || exit 0

if [ -f "$MARKER" ]; then
  AGE_MIN=$(( ( $(date +%s) - $(stat -f %m "$MARKER" 2>/dev/null || stat -c %Y "$MARKER") ) / 60 ))
  [ "$AGE_MIN" -le "$MARKER_TTL_MIN" ] && exit 0
  STALE=" (marker is ${AGE_MIN}min old; TTL ${MARKER_TTL_MIN}min)"
else
  STALE=""
fi

cat >&2 <<EOF
BLOCKED by hygiene gate: this command crosses the public boundary and no fresh
security-scan pass exists${STALE}.
Before retrying, do BOTH:
1. Load the publish-hygiene skill (or state you are running its checklist).
2. Run: ./scripts/security-scan.sh  — a clean pass writes the marker that
   opens this gate for ${MARKER_TTL_MIN} minutes.
If the scan reports findings, fix them first; do not push over a failing scan.
The user can force-open the gate with: touch .claude/.hygiene-gate-pass
EOF
exit 2
