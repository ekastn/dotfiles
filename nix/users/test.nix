{ pkgs, ... }:

{
  users.users."test" = {
    isNormalUser = true;
    description = "test user";
    shell = pkgs.zsh;
    packages = [ pkgs.starship ];
  };
}