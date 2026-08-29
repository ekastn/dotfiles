{ config, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
  networking.firewall = {
    enable = true;
    # for kde connect
    allowedTCPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedUDPPortRanges = [ { from = 1714; to = 1764; } ];
    allowedTCPPorts = [ 1716 ];
    allowedUDPPorts = [ 1716 ];
  };
}
