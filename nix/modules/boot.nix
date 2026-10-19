{ config, pkgs, ... }:

{
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    configurationLimit = 10;
    font = "${pkgs.hack-font}/share/fonts/truetype/Hack-Regular.ttf";
    fontSize = 28;
    # gfxmodeEfi = "1280x720";
  };

  boot.supportedFilesystems = [ "ntfs" ];
  boot.initrd.systemd.enable = true;
  boot.initrd.systemd.tpm2.enable = true;

  security.tpm2.enable = true;

  boot.initrd.luks.devices."luks-f380ccfc-58ab-42a7-8769-33a16bf49fc7".crypttabExtraOpts = [ "tpm2-device=auto" ];
  boot.initrd.luks.devices."luks-a90dcfb8-052c-4f9d-9521-e77800c587be".crypttabExtraOpts = [ "tpm2-device=auto" ];

  console = {
    earlySetup = true;
    font = "ter-v28n";
    packages = with pkgs; [ terminus_font ];
  };

  # systemd.services.systemd-vconsole-setup.unitConfig.After = [ "local-fs.target" ];
}
