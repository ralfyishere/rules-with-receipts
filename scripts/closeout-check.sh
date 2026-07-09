#!/bin/bash
# Final-closeout consistency sweep. Guards against the failure mode
# "local verification mistaken for global completion": after any pack,
# publish, or mirror change, every doc that REPEATS a fact (skill count,
# rule count, version, component list) must agree with the live state.
#
# Usage:
#   ./scripts/closeout-check.sh                  # sweep this repo
#   ./scripts/closeout-check.sh /path/to/public  # + drift vs a public-mirror clone
#
# Exit 0 = consistent; 1 = findings printed. Wired into .githooks/pre-push.
# LIMITS (by design, do the manual pass too): catches numeric/name drift and
# file-set drift; cannot catch prose describing outdated BEHAVIOR.
set -u
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT" || exit 1
FINDINGS=0
note() { echo "STALE: $*"; FINDINGS=$((FINDINGS+1)); }

# --- INSTALLED-PROJECT MODE -------------------------------------------------
# In a project the pack was installed into (no VERSION/install-pack.sh at
# root), closeout means: the installed pack is internally consistent and the
# managed blocks match what is installed. Project-specific docs are not
# policed for pack counts — they are the project's own.
if [ ! -f VERSION ] || [ ! -f install-pack.sh ]; then
  PV=$(awk '{print $1; exit}' .claude/PACK-VERSION 2>/dev/null || echo "")
  [ -n "$PV" ] || { note "no .claude/PACK-VERSION — pack not installed?"; }
  SKILLS=$(ls -d .claude/skills/*/ 2>/dev/null | wc -l | tr -d ' ')
  echo "ground truth (installed mode): $SKILLS skills, pack version ${PV:-UNKNOWN}"
  for blk in manual snippet; do
    MARK=$(grep -o "quality-pack:$blk:BEGIN v[0-9.]*" CLAUDE.md 2>/dev/null | head -1)
    [ -z "$MARK" ] && { note "CLAUDE.md missing managed block: $blk"; continue; }
    BV=${MARK##*BEGIN v}
    [ "$BV" = "$PV" ] || note "CLAUDE.md $blk block is v$BV but installed pack is v$PV (re-run installer)"
  done
  SNIP_N=$(awk '/^```markdown$/{f=1;next} /^```$/{f=0} f' .claude/skills/CLAUDE-MD-SNIPPET.md 2>/dev/null | grep -c '^- ')
  CM_N=$(awk '/quality-pack:snippet:BEGIN/{f=1} /quality-pack:snippet:END/{f=0} f' CLAUDE.md 2>/dev/null | grep -c '^- ')
  [ "$SNIP_N" = "$CM_N" ] || note "snippet rules: CLAUDE.md block has $CM_N, installed snippet file has $SNIP_N"
  grep -q "hygiene-gate.sh" .claude/settings.json 2>/dev/null || note ".claude/settings.json: hygiene gate hook not wired"
  for s in hygiene-gate.sh security-scan.sh check-pack.sh closeout-check.sh test-hygiene-gate.sh; do
    [ -x "scripts/$s" ] || note "scripts/$s missing or not executable"
  done
  echo
  if [ "$FINDINGS" = "0" ]; then echo "CLOSEOUT: consistent (installed mode)"; exit 0
  else echo "CLOSEOUT: $FINDINGS finding(s)"; exit 1; fi
fi
# --- PACK-SOURCE MODE (below) -----------------------------------------------

# --- ground truth from live state ---
SKILLS=$(ls -d .claude/skills/*/ | wc -l | tr -d ' ')
RULES=$(awk '/^```markdown$/{f=1;next} /^```$/{f=0} f' .claude/skills/CLAUDE-MD-SNIPPET.md | grep -c '^- ')
VERSION=$(tr -d '[:space:]' < VERSION)
echo "ground truth: $SKILLS skills, $RULES snippet rules, version $VERSION"

# --- 1. counts: any "N skills" / "N always-on rules" claim must match ---
# Exempt: evidence dirs (immutable), learnings + CHANGELOG (dated history is
# correct as history), and this script (detector self-match).
DOCS=$(git ls-files '*.md' '*.sh' | grep -vE '^eval-results.*/(raw|fixtures|prompts)|^\.claude/learnings/|^study-draft/|raw-regression|CHANGELOG\.md|scripts/closeout-check\.sh')
HITS=$( (for f in $DOCS; do
  grep -HnEo '[0-9]+( [a-z]+)? skills' "$f" | grep -v ":$SKILLS skills" | grep -v ":$SKILLS [a-z]* skills"
  grep -HnEo "[0-9]+ always-on rules|[0-9]+ rules?( snippet| —)" "$f" | grep -vE ":($RULES) "
done) 2>/dev/null )
if [ -n "$HITS" ]; then
  echo "$HITS" | sed "s/^/STALE count (live: $SKILLS skills, $RULES rules): /"
  FINDINGS=$((FINDINGS + $(echo "$HITS" | wc -l | tr -d ' ')))
fi

# --- 2. version agreement: CHANGELOG top entry == VERSION ---
TOPVER=$(grep -m1 -Eo '^## [0-9]+\.[0-9]+\.[0-9]+' CHANGELOG.md | awk '{print $2}')
[ "$TOPVER" = "$VERSION" ] || { note "CHANGELOG top entry $TOPVER != VERSION $VERSION"; }

# --- 3. installer must not hardcode counts (they live in ground truth only) ---
grep -qE "[0-9]+ skills" install-pack.sh && note "install-pack.sh hardcodes a skill count — keep it count-free"

# --- 3b. continuity registry: exists and not stale on this repo's own entry ---
if [ -f ACTIVE-PROJECTS.md ]; then
  grep -q "Version:.*$VERSION" ACTIVE-PROJECTS.md \
    || note "ACTIVE-PROJECTS.md fable-skills entry does not list version $VERSION (registry went stale — update it at closeout)"
else
  note "ACTIVE-PROJECTS.md missing — the continuity registry is load-bearing (see SESSION-START.md)"
fi

# --- 4. every component in scripts/ + trigger-eval appears in PACK-MANIFEST ---
for comp in hygiene-gate.sh security-scan.sh audit-triggers.py check-pack.sh closeout-check.sh mirror-public.sh registry-check.sh; do
  [ -e "scripts/$comp" ] && ! grep -q "$comp" PACK-MANIFEST.md && note "PACK-MANIFEST.md missing scripts/$comp"
done
grep -q "trigger-eval" PACK-MANIFEST.md || note "PACK-MANIFEST.md missing trigger-eval/"

# --- 5. public-mirror drift (optional arg) ---
if [ $# -ge 1 ] && [ -d "$1" ]; then
  PUB="$1"
  echo "== mirror drift vs $PUB =="
  # Shared files must be identical:
  SHARED="CLAUDE.md CHANGELOG.md VERSION install-pack.sh bootstrap.sh INSTALL.md
          QUICK-START.md BOOTSTRAP-NEW-MACHINE.md PACK-MANIFEST.md RELEASE-CHECKLIST.md SECURITY.md
          scripts/release-test.sh
          .quality-pack/config.env.template .githooks/pre-push
          scripts/check-pack.sh scripts/hygiene-gate.sh scripts/test-hygiene-gate.sh
          scripts/audit-triggers.py scripts/security-scan-starter.sh scripts/closeout-check.sh
          .claude/settings.json trigger-eval/cases.json trigger-eval/run-trigger-eval.sh
          eval-results-v2/run-eval-v2.sh eval-results-v2/README.md"
  for f in $SHARED; do
    [ -e "$PUB/$f" ] || { note "mirror missing shared file: $f"; continue; }
    cmp -s "$f" "$PUB/$f" || note "mirror drift in shared file: $f"
  done
  diff -rq .claude/skills "$PUB/.claude/skills" >/dev/null 2>&1 || note "mirror drift in .claude/skills/"
  # Intentional divergences — everything else in the public root must exist here too:
  INTENTIONAL="README.md AGENTS.md LICENSE CONTRIBUTING.md"
  for f in $(cd "$PUB" && git ls-files | grep -v '/'); do
    case " $INTENTIONAL " in *" $f "*) continue;; esac
    [ -e "$f" ] || note "public-only root file not documented as intentional: $f"
  done
  # The personal scan must never be the public one:
  grep -q "REPOS_LOCAL" "$PUB/scripts/security-scan.sh" 2>/dev/null && note "PUBLIC security-scan.sh looks like the personal one (REPOS_LOCAL)"
  # Public manifest must list every script actually shipped there:
  for s in "$PUB"/scripts/*; do
    grep -q "$(basename "$s")" "$PUB/PACK-MANIFEST.md" || note "PUBLIC PACK-MANIFEST.md missing scripts/$(basename "$s")"
  done
fi

echo
if [ "$FINDINGS" = "0" ]; then echo "CLOSEOUT: consistent"; else echo "CLOSEOUT: $FINDINGS finding(s)"; exit 1; fi
