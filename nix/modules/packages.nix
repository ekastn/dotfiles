{ config, pkgs, antigravity-nix, nixpkgs-unstable, ... }:

{
  programs.codexDesktopLinux.enable = true;

  programs.kdeconnect.enable = true;
  programs.partition-manager.enable = true;

  programs.git = {
    enable = true;
    lfs.enable = true;
  };

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

    fio
    kdiskmark

    # CLI tools
    curl
    wget
    tmux
    pciutils
    usbutils
    rsync
    stow
    tree
    graphviz
    psmisc
    lsof
    file
    bat

    # File & archives
    unzip
    zip
    p7zip
    zstd
    gzip
    imagemagick
    ffmpeg-full
    pandoc
    ntfs3g

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
    lazydocker
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
    devenv
    direnv

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

    # AI tools
    antigravity-nix.packages.${pkgs.system}.google-antigravity-cli
  ];
}
