{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    autoPrune.enable = true;
    daemon.settings = {
      dns = [ "1.1.1.1" "8.8.8.8" ];
    };
  };

  virtualisation.libvirtd = {
    enable = true;
    qemu = {
      package = pkgs.qemu_kvm;
      runAsRoot = true;
      swtpm.enable = true;
      vhostUserPackages = with pkgs; [ virtiofsd ];
    };
  };

  programs.virt-manager.enable = true;

  environment.systemPackages = with pkgs; [
    virt-viewer
    libguestfs
    virtio-win
    docker-compose
  ];

  networking.firewall.trustedInterfaces = [ "virbr0" ];
}
