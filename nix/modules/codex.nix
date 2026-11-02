{ codex-desktop-linux, ... }:

{
  imports = [ codex-desktop-linux.nixosModules.default ];

  programs.codexDesktopLinux = {
    enable = true;
    remoteMobileControl.enable = true;
    computerUseUi.enable = true;
  };
}
