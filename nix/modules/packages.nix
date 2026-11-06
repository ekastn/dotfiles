{ config, pkgs, antigravity-nix, nixpkgs-unstable, nixpkgs-master, ... }:

let
  kdenlive-wrapped = pkgs.symlinkJoin {
    name = "kdenlive";
    paths = [ nixpkgs-unstable.legacyPackages.${pkgs.system}.kdePackages.kdenlive ];
    buildInputs = [ pkgs.makeWrapper ];
    postBuild = ''
      wrapProgram $out/bin/kdenlive \
        --prefix LADSPA_PATH : "${pkgs.lib.makeSearchPath "lib/ladspa" [
          pkgs.ladspaPlugins
          pkgs.tap-plugins
          pkgs.caps
          pkgs.rnnoise-plugin.ladspa
        ]}"
    '';
  };
in
{
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
    kubectl
    k9s
    plantuml
    google-drive-ocamlfuse

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
    zathura
    mediainfo

    # Terminal & editor
    vim
    neovim
    ghostty
    fzf
    ripgrep
    jq
    zoxide
    yazi
    ripdrag
    btop
    fastfetch
    lazygit
    lazydocker
    atuin
    go-task
    tree-sitter
    fd
    gh

    # Desktop apps
    nixpkgs-master.legacyPackages.${pkgs.system}.t3code
    nixpkgs-unstable.legacyPackages.${pkgs.system}.audacity
    nixpkgs-unstable.legacyPackages.${pkgs.system}.winboat
    freerdp
    mpv
    vlc
    gimp3
    inkscape
    onlyoffice-desktopeditors
    spotify
    gearlever
    wmctrl
    kdotool
    wl-clipboard
    mangohud
    mesa-demos
    obsidian
    typora
    kdenlive-wrapped
    vscode

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

    # Postgres client (psql, pg_dump) — server only runs with services.postgresql.enable
    postgresql

    # Languages & runtimes
    uv
    # PHP 8.4 for Laravel local dev (markicabs-pos): pgsql/gd/intl on top of defaults
    (php84.withExtensions ({ enabled, all }: enabled ++ (with all; [ pdo_pgsql pgsql gd intl ])))
    php84Packages.composer
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
    python3

    # Network
    nmap

    # AI tools
    antigravity-nix.packages.${pkgs.system}.google-antigravity-cli
    antigravity-nix.packages.${pkgs.system}.default
  ];
}
