{ config, pkgs, ... }:

{
  programs.kdeconnect.enable = true;

  environment.systemPackages = with pkgs; [
    # Browsers
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

    # CLI tools
    curl
    wget
    git
    tmux
    pciutils
    usbutils
    rsync
    stow
    tree
    graphviz

    # File & archives
    unzip
    zip
    p7zip
    zstd
    gzip
    imagemagick
    ffmpeg-full
    pandoc

    # Terminal & editor
    vim
    neovim
    ghostty
    fzf
    ripgrep
    jq
    zoxide
    yazi
    btop
    fastfetch
    lazygit
    atuin
    go-task
    tree-sitter
    fd

    # Desktop apps
    audacity
    gimp3
    inkscape
    onlyoffice-desktopeditors
    spotify
    gearlever
    mangohud
    mesa-demos

    # Dev toolchain
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
    goose
    sqlc

    # Languages & runtimes
    uv
    nodejs
    pnpm
    bun
    go
    rustc
    cargo
    rustfmt
    jdk21
    maven
    gradle

    # Network
    nmap
  ];
}
