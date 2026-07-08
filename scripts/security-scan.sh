#!/bin/bash
# Generic pre-push security scan (installed by the quality pack as
# scripts/security-scan.sh if the target project has none).
# Scans THIS repo's full history for secrets and identity leakage.
# A clean pass opens the hygiene gate (scripts/hygiene-gate.sh) for its TTL.
# Customize the patterns for your environment; keep the exit contract:
# exit 0 + touch marker = clean, nonzero = findings printed.
set -u
cd "$(git rev-parse --show-toplevel 2>/dev/null || pwd)" || exit 1
FINDINGS=0
note() { echo "FINDING: $*"; FINDINGS=$((FINDINGS+1)); }

SECRET_PATTERN='sk-ant-|ghp_[A-Za-z0-9]|gho_[A-Za-z0-9]|github_pat_|AKIA[0-9A-Z]{16}|BEGIN [A-Z ]*PRIVATE KEY|xox[bp]-|-----BEGIN'
# Machine identity that should not appear in shareable content:
ME_USER="$(whoami)"
ME_HOST="$(hostname -s 2>/dev/null || echo NOHOST)"

if [ -d .git ]; then
  echo "== history: secrets =="
  hits=$(git grep -IiEl "$SECRET_PATTERN" $(git rev-list --all) -- 2>/dev/null | head -5)
  [ -n "$hits" ] && note "possible secrets in history:" && echo "$hits"

  echo "== history: machine identity ($ME_USER / $ME_HOST) =="
  ihits=$(git grep -IilE "/Users/$ME_USER|/home/$ME_USER|$ME_HOST" $(git rev-list --all) -- 2>/dev/null | grep -v 'settings.local' | head -5)
  [ -n "$ihits" ] && note "machine username/hostname in history:" && echo "$ihits"

  echo "== history: author/committer identities =="
  git log --format='%ae%n%ce' | sort -u | sed 's/^/  /'
  echo "  ^ verify each is an identity you intend to be public"
fi

echo
if [ "$FINDINGS" = "0" ]; then
  touch "$(pwd)/.claude/.hygiene-gate-pass" 2>/dev/null
  echo "SECURITY SCAN: clean (hygiene gate opened)"
else
  echo "SECURITY SCAN: $FINDINGS finding(s) above"; exit 1
fi
