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

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib
    glibc
    zlib
    openssl
    glib
    libX11
    libXext
    libXrender
    libXtst
    libglvnd
  ];

  services.flatpak.enable = true;

  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = ["nix-command" "flakes"];
}
