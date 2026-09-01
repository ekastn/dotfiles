#!/usr/bin/env bash
# Apply the tracked KDE config from this repo to ~/.config and ~/.local/share.
#
# Copies (not symlinks) so Plasma's rewrite-on-logout never dirties the repo.
# Only touches the tracked set; leaves all other config alone. If a live file
# was modified outside the repo, it is overwritten here.
#
# Usage: ./apply.sh
set -euo pipefail

DOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CFG_DIR="$DOT_DIR/.config"
SHARE_DIR="$DOT_DIR/.local/share"
LIVE="$HOME/.config"
LIVE_SHARE="$HOME/.local/share"

CONFIG_FILES=(
  kglobalshortcutsrc
  kwinrc
  kdeglobals
  kwinrulesrc
  kxkbrc
  powerdevilrc
  kscreenlockerrc
  konsolerc
  krunnerrc
  dolphinrc
  spectaclerc
  plasma-localerc
  mimeapps.list
  baloofilerc
  kded6rc
  plasmarc
  plasma-org.kde.plasma.desktop-appletsrc
)

SHARE_DIRS=(
  color-schemes/Nothing.colors
  color-schemes/NothingLightly.colors
  plasma/desktoptheme/Sweet-mars
  plasma/plasmoids/com.mike.desktop
  plasma/plasmoids/org.kde.windowtitle
)

for f in "${CONFIG_FILES[@]}"; do
  if [ -f "$CFG_DIR/$f" ]; then
    cp "$CFG_DIR/$f" "$LIVE/$f"
    echo "applied $f"
  fi
done

for d in "${SHARE_DIRS[@]}"; do
  if [ -e "$SHARE_DIR/$d" ]; then
    mkdir -p "$(dirname "$LIVE_SHARE/$d")"
    cp -r "$SHARE_DIR/$d" "$LIVE_SHARE/$d"
    echo "applied $d"
  fi
done

echo
echo "Applied. Log out and back in for Plasma to pick up the changes."
echo "Notes for a fresh machine:"
echo "  - install the icon theme (nix: pkgs.papirus-icon-theme)"
echo "  - re-apply your tiling layouts (they are not shipped per-machine)"
echo "  - set wallpaper (kscreenlockerrc/plasmarc ship without wallpapers)"
