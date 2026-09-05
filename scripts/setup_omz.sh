#!/usr/bin/env bash
set -euo pipefail

OMZ_DIR="$HOME/.oh-my-zsh"
OMZ_REPO="https://github.com/ohmyzsh/ohmyzsh.git"
NIX_SHELL_REPO="https://github.com/chisui/zsh-nix-shell.git"

if [[ -d "$OMZ_DIR" ]]; then
  echo "oh-my-zsh already present at $OMZ_DIR"
else
  git clone --depth 1 "$OMZ_REPO" "$OMZ_DIR"
fi

PLUGIN_DIR="$OMZ_DIR/custom/plugins/nix-shell"
if [[ -d "$PLUGIN_DIR" ]]; then
  echo "zsh-nix-shell already present at $PLUGIN_DIR"
else
  git clone --depth 1 "$NIX_SHELL_REPO" "$PLUGIN_DIR"
fi

echo "done: oh-my-zsh + nix-shell plugin ready"