#!/bin/bash
# Generic pre-push security scan (installed by the quality pack as
# scripts/security-scan.sh if the target project has none).
# Scans THIS repo's full history for secrets and identity leakage, plus the
# GitHub surface when QP_GH_OWNER is configured.
# A clean pass opens the hygiene gate (scripts/hygiene-gate.sh) for its TTL.
# Project-local settings: .quality-pack/config.env (owned by the project).
# Exit contract: exit 0 + touch marker = clean; nonzero = findings printed.
set -u
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)" || exit 1
[ -f .quality-pack/config.env ] && . .quality-pack/config.env
FINDINGS=0
note() { echo "FINDING: $*"; FINDINGS=$((FINDINGS+1)); }

SECRET_PATTERN='sk-ant-|ghp_[A-Za-z0-9]|gho_[A-Za-z0-9]|github_pat_|AKIA[0-9A-Z]{16}|BEGIN [A-Z ]*PRIVATE KEY|xox[bp]-'
[ -n "${QP_EXTRA_SECRET_PATTERNS:-}" ] && SECRET_PATTERN="$SECRET_PATTERN|$QP_EXTRA_SECRET_PATTERNS"
# Machine identity that should not appear in shareable content:
ME_USER="$(whoami)"
ME_HOST="$(hostname -s 2>/dev/null || echo NOHOST)"
LEAK_PATTERN="/Users/$ME_USER|/home/$ME_USER|$ME_HOST"
[ -n "${QP_EXTRA_LEAK_PATTERNS:-}" ] && LEAK_PATTERN="$LEAK_PATTERN|$QP_EXTRA_LEAK_PATTERNS"
# Detector self-match exemption (these files CONTAIN the patterns):
DETECTORS=':!scripts/security-scan*.sh :!scripts/hygiene-gate.sh'

if [ -d .git ]; then
  # A failed/empty rev-list must be a finding, not a silent "clean" — the greps
  # below would quietly scan nothing. Capture the rev list ONCE and reuse it.
  if ! REVS="$(git rev-list --all 2>/dev/null)" || [ -z "$REVS" ]; then
    note "history unreadable (rev-list failed/empty) — NOT scanned"
  else
  # git grep: rc 0 = match, rc 1 = no match (clean), rc>=2 = real error.
  # A tool error must be a FINDING, never read as zero hits (fail closed).
  echo "== history: secrets =="
  hits=$(git grep -IiEl "$SECRET_PATTERN" $REVS -- $DETECTORS 2>/dev/null); grc=$?
  if [ "$grc" -gt 1 ]; then note "git grep errored (rc=$grc) scanning history for secrets — NOT reliably scanned"
  elif [ -n "$hits" ]; then note "possible secrets in history:" && echo "$hits" | head -5; fi

  echo "== history: machine identity ($ME_USER / $ME_HOST) =="
  iraw=$(git grep -IilE "$LEAK_PATTERN" $REVS -- $DETECTORS 2>/dev/null); grc=$?
  ihits=$(printf '%s\n' "$iraw" | grep -v 'settings.local')
  if [ "$grc" -gt 1 ]; then note "git grep errored (rc=$grc) scanning history for machine identity — NOT reliably scanned"
  elif [ -n "$iraw" ] && [ -n "$ihits" ]; then note "machine username/hostname in history:" && echo "$ihits" | head -5; fi
  fi

  echo "== history: author/committer identities =="
  IDS=$(git log --format='%ae%n%ce' 2>/dev/null | sort -u)
  if [ -n "${QP_ALLOWED_GIT_EMAILS:-}" ]; then
    for id in $IDS; do
      case " $QP_ALLOWED_GIT_EMAILS " in
        *" $id "*) ;;
        *) note "history identity not in QP_ALLOWED_GIT_EMAILS: $id" ;;
      esac
    done
  else
    echo "$IDS" | sed 's/^/  /'
    echo "  ^ verify each is an identity you intend to be public"
    echo "    (set QP_ALLOWED_GIT_EMAILS in .quality-pack/config.env to enforce)"
  fi
fi

if [ -n "${QP_GH_OWNER:-}" ] && command -v gh >/dev/null 2>&1; then
  echo "== GitHub surface ($QP_GH_OWNER) =="
  for R in $(gh repo list "$QP_GH_OWNER" --json name --jq '.[].name' 2>/dev/null); do
    h=$(gh api "repos/$QP_GH_OWNER/$R/hooks" --jq length 2>/dev/null || echo "?")
    k=$(gh api "repos/$QP_GH_OWNER/$R/keys" --jq length 2>/dev/null || echo "?")
    vis=$(gh api "repos/$QP_GH_OWNER/$R" --jq .visibility 2>/dev/null)
    ss=$(gh api "repos/$QP_GH_OWNER/$R" --jq '.security_and_analysis.secret_scanning.status // "n/a"' 2>/dev/null)
    [ "$h" != "0" ] && [ "$h" != "?" ] && note "$R: $h webhook(s) — verify each"
    [ "$k" != "0" ] && [ "$k" != "?" ] && note "$R: $k deploy key(s) — verify each"
    [ "$vis" = "public" ] && [ "$ss" != "enabled" ] && note "$R: public without secret scanning"
    echo "  $R: hooks=$h keys=$k ss=$ss"
  done
fi

echo
if [ "$FINDINGS" = "0" ]; then
  mkdir -p .claude
  touch "$(pwd)/.claude/.hygiene-gate-pass"
  echo "SECURITY SCAN: clean (hygiene gate opened)"
else
  echo "SECURITY SCAN: $FINDINGS finding(s) above"; exit 1
fi
