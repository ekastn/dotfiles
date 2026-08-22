#!/usr/bin/env bash
# Fetch pinned external dependencies for Bart KDE theme
# Run this once to populate cursors/ in the dotfiles dir

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Pinned version — update to change versions
WHITESUR_COMMIT="e190baf618ed95ee217d2fd45589bd309b37672b"

TMPDIR=$(mktemp -d)
trap 'rm -rf "$TMPDIR"' EXIT

echo "=== Fetching WhiteSur-cursors (${WHITESUR_COMMIT:0:7}) ==="
curl -sL "https://api.github.com/repos/vinceliuice/WhiteSur-cursors/zipball/$WHITESUR_COMMIT" \
  -o "$TMPDIR/whitesur.zip"
unzip -qo "$TMPDIR/whitesur.zip" -d "$TMPDIR/whitesur"
WHITESUR_DIR=$(find "$TMPDIR/whitesur" -maxdepth 1 -type d -name "vinceliuice-*" | head -1)

if [ -d "$WHITESUR_DIR/dist" ]; then
  mkdir -p "$SCRIPT_DIR/cursors/WhiteSur"
  cp -r "$WHITESUR_DIR/dist"/* "$SCRIPT_DIR/cursors/WhiteSur/"
  echo "  Installed: $(ls "$SCRIPT_DIR/cursors/WhiteSur/")"
else
  echo "  ERROR: dist/ not found in WhiteSur-cursors repo"
  echo "  Contents: $(ls "$WHITESUR_DIR")"
  exit 1
fi

echo ""
echo "=== Done ==="
echo "Run ./install.sh to apply."
