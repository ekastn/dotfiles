{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    font = "${pkgs.hack-font}/share/fonts/truetype/Hack-Regular.ttf";
    fontSize = 28;
    gfxmodeEfi = "1280x720";
  };

  console = {
    earlySetup = true;
    font = "ter-v20n";
    packages = with pkgs; [ terminus_font ];
  };

  systemd.services.systemd-vconsole-setup.unitConfig.After = [ "local-fs.target" ];
}
