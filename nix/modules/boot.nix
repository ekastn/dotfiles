{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    fontSize = 32;
  };

  console = {
    earlySetup = true;
    font = "ter-v24n";
    packages = with pkgs; [ terminus_font ];
  };

  systemd.services.systemd-vconsole-setup.unitConfig.After = [ "local-fs.target" ];
}
