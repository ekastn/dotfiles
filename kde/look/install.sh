#!/usr/bin/env bash
# Install Bart KDE theme from dotfiles
# Copies all theme files to the correct system locations

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
LOCAL="$HOME/.local/share"

echo "=== Installing Bart KDE theme ==="

# Colorschemes
if [ -d "$SCRIPT_DIR/colorschemes" ]; then
  echo "  colorschemes -> $LOCAL/color-schemes/"
  mkdir -p "$LOCAL/color-schemes"
  cp "$SCRIPT_DIR/colorschemes/"* "$LOCAL/color-schemes/"
fi

# Aurorae window decorations
if [ -d "$SCRIPT_DIR/aurorae" ]; then
  echo "  aurorae -> $LOCAL/aurorae/themes/"
  mkdir -p "$LOCAL/aurorae/themes"
  cp -r "$SCRIPT_DIR/aurorae/"* "$LOCAL/aurorae/themes/"
fi

# Plasma desktop theme
if [ -d "$SCRIPT_DIR/plasma" ]; then
  echo "  plasma -> $LOCAL/plasma/desktoptheme/"
  mkdir -p "$LOCAL/plasma/desktoptheme"
  cp -r "$SCRIPT_DIR/plasma/"* "$LOCAL/plasma/desktoptheme/"
fi

# Look-and-feel package
if [ -d "$SCRIPT_DIR/look-and-feel" ]; then
  echo "  look-and-feel -> $LOCAL/plasma/look-and-feel/"
  mkdir -p "$LOCAL/plasma/look-and-feel"
  cp -r "$SCRIPT_DIR/look-and-feel/"* "$LOCAL/plasma/look-and-feel/"
fi

# Cursors
if [ -d "$SCRIPT_DIR/cursors" ] && [ "$(ls -A "$SCRIPT_DIR/cursors" 2>/dev/null)" ]; then
  echo "  cursors -> $LOCAL/icons/"
  mkdir -p "$LOCAL/icons"
  cp -r "$SCRIPT_DIR/cursors/"* "$LOCAL/icons/"
fi

echo ""
echo "=== Installed. To apply, run: ==="
echo "  plasma-apply-lookandfeel -a Bart"
echo ""
echo "Or apply via System Settings > Appearance > Global Theme > Bart"
