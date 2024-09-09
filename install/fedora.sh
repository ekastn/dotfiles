#!/bin/sh

fonts=open-sans-fonts rsms-inter-fonts rsms-inter-vf-fonts
pkgs=hyprland hypridle hyprlock hyprpaper rofi foot mpv fzf ripgrep nvim thunar gzip
pkgs=make automake gcc gcc-c++ kernel-devel

dnf copr enable solopasha/hyprland
dnf install hyprland
