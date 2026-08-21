{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf
      inter
    ];
    fontconfig.defaultFonts = {
      sansSerif = [ "Noto Sans" "Liberation Sans" ];
      serif = [ "Noto Serif" "Liberation Serif" ];
      monospace = [ "Noto Sans Mono" "Liberation Mono" ];
      emoji = [ "Noto Color Emoji" ];
    };
  };
}
