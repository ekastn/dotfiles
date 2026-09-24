{ ... }:

{
  services.openssh = {
    enable = true;
    openFirewall = false;
    authorizedKeysInHomedir = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
