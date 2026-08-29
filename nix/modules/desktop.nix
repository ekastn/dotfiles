{ config, pkgs, ... }:

{
  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  environment.systemPackages = with pkgs.kdePackages; [
    sddm-kcm
  ];

  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  services.printing = {
    enable = true;
    drivers = [ pkgs.gutenprint ];
  };
}
