{ config, pkgs, ... }:

{
  programs.zsh.enable = true;

  programs.firefox.enable = true;
  programs.zoom-us.enable = true;

  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  programs.direnv = {
    enable = true;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    glibc
    openssl
    glib
    gtk3
    cairo
    pango
    gdk-pixbuf
    dbus
    cups
    libX11
    libXcomposite
    libXdamage
    libXext
    libXfixes
    libXrender
    libXtst
    libXi
    libXcursor
    libXrandr
    libxcb
    libXxf86vm
    libglvnd
    libxkbcommon
    libxshmfence
    alsa-lib
    atk
    at-spi2-atk
    at-spi2-core
    fontconfig
    freetype
    libdrm
    libgbm
    libGL
    mesa
    wayland
    systemd
    stdenv.cc.cc
    zlib
    expat
    nspr
    nss
    pipewire
    vulkan-loader
    libva
    libXinerama
    libXScrnSaver
    libSM
    libICE
    libXt
    libXmu
    SDL2
    SDL2_image
    SDL2_mixer
    SDL2_ttf
    libusb1
    libcap
    libelf
    icu
    libnotify
    curl
    bzip2
    libpng
    libjpeg
    libtiff
    harfbuzz
  ];

  services.flatpak.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
