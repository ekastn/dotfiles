{ pkgs, ... }:

{
  users.users."heaven" = {
    isNormalUser = true;
    description = "heaven";
    extraGroups = [ "networkmanager" "wheel" "gamemode" "docker" "libvirtd" "audio" "input" ];
    shell = pkgs.zsh;
  };
}