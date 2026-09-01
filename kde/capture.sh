#!/usr/bin/env bash
# Capture the current KDE config back into this repo, sanitizing volatile and
# machine-specific keys so `git diff` shows only deliberate changes.
#
# Run this after tweaking anything in System Settings. It never touches the
# live config; it only copies ~/.config -> ./ and then stages nothing itself.
# Review the diff with `git status --short` + `git diff`, then commit.
#
# Usage: ./capture.sh
set -euo pipefail

DOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CFG_DIR="$DOT_DIR/.config"
SHARE_DIR="$DOT_DIR/.local/share"
LIVE="$HOME/.config"
LIVE_SHARE="$HOME/.local/share"

# Files worth tracking, mirrored 1:1 in ~/.config.
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
  plasmashellrc
  plasma-org.kde.plasma.desktop-appletsrc
)

# Directories in ~/.local/share that hold theme content and custom widgets.
SHARE_DIRS=(
  color-schemes/Nothing.colors
  color-schemes/NothingLightly.colors
  plasma/desktoptheme/Sweet-mars
  plasma/plasmoids/com.mike.desktop
  plasma/plasmoids/org.kde.windowtitle
)

# Sanitize one config file: strip volatile / machine-specific keys.
# Input is the raw live file on stdin, output the cleaned copy on stdout.
sanitize() {
  local name="$1"
  case "$name" in
    kwinrc)
      # Drop per-desktop UUID ids (keep Number/Rows) and the whole [Tiling] section.
      awk '
        /^\[/ {
          if ($0 ~ /^\[Tiling\]/) { intiling = 1; next }
          intiling = 0
          indesktops = 0
          if ($0 ~ /^\[Desktops\]$/) indesktops = 1
          print; next
        }
        intiling { next }
        indesktops && /^Id_[0-9]+=/ { next }
        { print }
      '
      ;;
    kglobalshortcutsrc)
      # Drop the chromium extension block and per-activity UUID shortcut lines.
      awk '
        /^\[/ {
          if ($0 ~ /^\[org\.chromium\.Chromium\]/) { inchromium = 1; next }
          inchromium = 0
          print; next
        }
        inchromium { next }
        /^switch-to-activity-[0-9a-f-]+=/ { next }
        { print }
      '
      ;;
    kscreenlockerrc)
      # Keep the [Daemon] timeout, drop the greeter wallpaper (absolute path).
      awk '
        /^\[Greeter\]/ { ingreeter = 1; next }
        !ingreeter { print }
      '
      ;;
    plasmarc)
      # Keep the theme name, drop the wallpaper path list.
      awk '
        /^\[Wallpapers\]/ { inwalls = 1; next }
        !inwalls { print }
      '
      ;;
    plasmashellrc)
      # Keep the per-panel view settings (visibility, thickness, floating),
      # drop the [Updates] marker list (machine-specific store paths).
      awk '/^\[Updates\]/ { skip = 1; next }
           /^\[/ { skip = 0 }
           !skip { print }'
      ;;
    plasma-org.kde.plasma.desktop-appletsrc)
      # Keep panel/widget structure + settings and the activity/screen
      # assignment (needed for panels to bind to a screen); drop only
      # resolution-specific caches, dialog geometry, and wallpaper paths.
      awk '
        /^\[ScreenMapping\]/ { inmap = 1; next }
        inmap { next }
        /^\[Containments\]\[[0-9]+\]$/ { top = 1; print; next }
        /^\[/ { top = 0 }
        top && /^lastScreen=/ { print "lastScreen=0"; next }
        /^(popupHeight|popupWidth|DialogHeight|DialogWidth|ItemGeometries)/ { next }
        /^Image=/ { next }
        /^SlidePaths=/ { next }
        { print }
      '
      ;;
    dolphinrc)
      sed '/^ViewPropsTimestamp=/d'
      ;;
    spectaclerc)
      sed '/^lastImageSave[^=]*Location=/d'
      ;;
    kdeglobals)
      # Normalize icon theme for both KDE and GTK; drop the machine-derived
      # colorscheme hash so Plasma recomputes it from the actual installed
      # scheme on each machine (prevents fallback to Breeze on a fresh box).
      sed -e 's/^Theme=breeze-dark$/Theme=Papirus/' -e '/^ColorSchemeHash=/d'
      ;;
    *)
      cat
      ;;
  esac
}

for f in "${CONFIG_FILES[@]}"; do
  if [ -f "$LIVE/$f" ]; then
    sanitize "$f" < "$LIVE/$f" > "$CFG_DIR/$f"
    echo "captured $f"
  else
    echo "skip (not present): $f"
  fi
done

for d in "${SHARE_DIRS[@]}"; do
  if [ -e "$LIVE_SHARE/$d" ]; then
    mkdir -p "$(dirname "$SHARE_DIR/$d")"
    cp -r "$LIVE_SHARE/$d" "$SHARE_DIR/$d"
    echo "captured $d"
  else
    echo "skip (not present): $d"
  fi
done

echo
echo "Captured. Review changes and commit:"
echo "  git -C '$DOT_DIR' status --short"