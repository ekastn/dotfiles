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
  ];

  networking.hostName = "dune";
  time.timeZone = "Asia/Jakarta";
  i18n.defaultLocale = "en_US.UTF-8";

  users.users."heaven" = {
    isNormalUser = true;
    description = "heaven";
    extraGroups = [ "networkmanager" "wheel" "gamemode" "docker" "libvirtd" ];
    shell = pkgs.zsh;
  };

  system.stateVersion = "26.05";
}
