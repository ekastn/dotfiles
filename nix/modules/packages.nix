{ config, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    vim
    (chromium.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    })
    (vivaldi.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    })
    curl
    wget
    git
    tmux
    pciutils
    usbutils
    unzip
    zip
    p7zip
    imagemagick
    ffmpeg-full
    ghostty
    neovim
    fzf
    ripgrep
    jq
    zoxide
    rsync
    zstd
    gzip
    go-task
    tree-sitter

    yazi
    stow
    btop
    fastfetch
    tree
    pandoc
    audacity
    gimp3
    inkscape
    onlyoffice-desktopeditors
    lazygit
    atuin
    gearlever
    mangohud
    mesa-demos

    gcc
    cmake
    gnumake
    pkg-config
    openssl
    clang
    clang-tools
    gnupg
    pass
    pinentry-qt

    uv
    nodejs
    bun
    go
    rustc
    cargo
    rustfmt
    nmap
  ];
}
