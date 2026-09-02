{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/boot.nix
    ../../modules/desktop.nix
    ../../modules/hardware.nix
    ../../modules/audio.nix
    ../../modules/networking.nix
    ../../modules/gaming.nix
    ../../modules/system.nix
    ../../modules/packages.nix
    ../../modules/fonts.nix
    ../../modules/virtualization.nix
    ../../users/test.nix
    ../../users/heaven.nix
  ];

  networking.hostName = "dune";
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  system.stateVersion = "26.05";
}
