{ pkgs, ... }:

{
  fonts = {
    enableDefaultPackages = true;
    packages = with pkgs; [
      # Base & Multilingual
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-color-emoji
      liberation_ttf

      # UI & General
      inter
      open-sans
      comfortaa

      # Coding & Monospace
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.fantasque-sans-mono
      nerd-fonts.meslo-lg
      source-code-pro

      # Icons
      font-awesome

      # Document & MS Compatibility
      corefonts
      carlito
      caladea
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        sansSerif = [ "Inter" "Noto Sans" "Liberation Sans" ];
        serif = [ "Noto Serif" "Liberation Serif" ];
        monospace = [ "JetBrainsMono Nerd Font" "Noto Sans Mono" "Liberation Mono" ];
        emoji = [ "Noto Color Emoji" ];
      };
    };
  };
}
