{ config, pkgs, nixpkgs-unstable, ... }:

{
  disabledModules = [ "services/display-managers/ly.nix" ];
  imports = [ "${nixpkgs-unstable}/nixos/modules/services/display-managers/ly.nix" ];

  services.xserver.enable = true;

  services.displayManager.ly.enable = true;
  services.displayManager.ly.package = nixpkgs-unstable.legacyPackages.${pkgs.stdenv.hostPlatform.system}.ly;
  services.displayManager.ly.settings = {
    # animation = "gameoflife";
    # gameoflife_fg = "0x01FF0000";
    # gameoflife_frame_delay = 10;
    # gameoflife_initial_density = 0.1;
    # bigclock = "en";
    clock = "%c";
    vi_mode = true;
    corner_top_left = "clock";
    corner_top_right = "numlock,capslock";
    corner_bottom_left = "shutdown,restart,britup,britdown,password battery binds";
    corner_bottom_right = "version";
  };
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
