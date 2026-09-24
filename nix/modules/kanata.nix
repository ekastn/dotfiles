{ lib, ... }:

{
  services.kanata = {
    enable = true;
    keyboards.dune = {
      configFile = ../../keyboard/vim.kbd;
    };
  };

  # Disable DynamicUser so Kanata runs as root and can access /dev/uinput despite Steam uaccess ACLs
  systemd.services.kanata-dune.serviceConfig.DynamicUser = lib.mkForce false;
}

