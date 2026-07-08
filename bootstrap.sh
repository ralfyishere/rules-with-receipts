#!/bin/bash
# One-command bootstrap: fetch the quality pack and install it into a project.
#
#   curl -fsSL https://raw.githubusercontent.com/ralfyishere/rules-with-receipts/main/bootstrap.sh | bash -s -- /path/to/project
#
# Honest note (this pack's own rule): piping a URL to bash is running unread
# code. The safer documented path is:
#   git clone https://github.com/ralfyishere/rules-with-receipts.git
#   (read it, or run: rulebench vet rules-with-receipts)
#   ./rules-with-receipts/install-pack.sh /path/to/project
# This script only automates exactly those steps.
set -euo pipefail
REPO="${QP_REPO:-https://github.com/ralfyishere/rules-with-receipts.git}"
DEST="${QP_HOME:-$HOME/.quality-pack-src}"
TARGET="${1:?usage: bootstrap.sh /path/to/project}"

if [ -d "$DEST/.git" ]; then
  echo "Updating pack source in $DEST ..."
  git -C "$DEST" pull --ff-only
else
  echo "Cloning pack source to $DEST ..."
  git clone "$REPO" "$DEST"
fi

if [ -f "$TARGET/.claude/PACK-VERSION" ]; then
  exec "$DEST/install-pack.sh" --upgrade "$TARGET"
else
  exec "$DEST/install-pack.sh" "$TARGET"
fi
