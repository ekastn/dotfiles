{ config, pkgs, nixpkgs-unstable, ... }:

{
  disabledModules = [ "services/display-managers/ly.nix" ];
  imports = [ "${nixpkgs-unstable}/nixos/modules/services/display-managers/ly.nix" ];

  services.xserver.enable = true;

  services.displayManager.ly.enable = true;
  services.desktopManager.plasma6.enable = true;

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };
}
