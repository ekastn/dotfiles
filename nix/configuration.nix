# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    fontSize = 32;
  };

  console = {
    earlySetup = true;
    font = "ter-v32n";
    packages = with pkgs; [ terminus_font ];
  };

  networking.hostName = "dune"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Asia/Jakarta";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Enable the X11 windowing system.
  # You can disable this if you're only using the Wayland session.
  services.xserver.enable = true;

  # Enable the KDE Plasma Desktop Environment.
  services.displayManager.sddm.enable = true;
  services.desktopManager.plasma6.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

  services.tailscale.enable = true;
  services.flatpak.enable = true;

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      intel-media-driver
      intel-vaapi-driver
    ];
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."heaven" = {
    isNormalUser = true;
    description = "heaven";
    extraGroups = [ "networkmanager" "wheel" "gamemode" ];
    shell = pkgs.zsh;
    packages = with pkgs; [
    #  kdePackages.kate
    #  thunderbird
    ];
  };

  programs.firefox.enable = true;
  programs.zsh.enable = true;
  programs.zoom-us.enable = true;
  programs.appimage = {
    enable = true;
    binfmt = true;
  };

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
    extraCompatPackages = with pkgs; [ proton-ge-bin ];
  };

  programs.gamescope.enable = true;
  programs.gamemode.enable = true;

  programs.obs-studio = {
    enable = true;
    plugins = with pkgs.obs-studio-plugins; [
      wlrobs
      obs-pipewire-audio-capture
      obs-vaapi
      obs-vkcapture
    ];
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    vim
    (chromium.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    })
    (vivaldi.override {
      commandLineArgs = [
        "--ozone-platform-hint=auto"
      ];
    })
    curl
    wget
    git
    tmux
    pciutils
    usbutils
    unzip
    zip
    p7zip
    imagemagick
    ffmpeg-full
    ghostty
    neovim
    fzf
    ripgrep
    jq
    zoxide
    rsync
    zstd
    gzip
    go-task
    tree-sitter

    yazi
    stow
    btop
    fastfetch
    tree
    pandoc
    audacity
    gimp3
    inkscape
    onlyoffice-desktopeditors
    lazygit
    atuin
    gearlever
    mangohud
    mesa-demos

    gcc
    cmake             
    gnumake
    pkg-config
    openssl
    clang
    clang-tools
    gnupg 
    pass
    pinentry-qt

    uv
    nodejs
    bun
    go
    rustc
    cargo
    rustfmt
    nmap
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  programs.gnupg.agent = {
    enable = true;
    enableSSHSupport = true;
    pinentryPackage = pkgs.pinentry-qt;
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc.lib    # Menyediakan libstdc++.so dan libgcc_s.so untuk binary eksternal
    glibc               # Standard C library
    
    # --- Common Dev Libraries (Sering dicari compiler luar & tools backend) ---
    zlib                # Kompresi standar, sering dipakai Go/Rust tools
    openssl             # Kriptografi/SSL runtime
    glib                # Library inti untuk banyak perkakas CLI/GUI moderen
    
    # --- System & X11/Graphics Helpers (Biar dev tools GUI tidak blank) ---
    libX11
    libXext
    libXrender
    libXtst
    libglvnd            # Vendor-neutral OpenGL
  ];

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  nix.settings.experimental-features = ["nix-command" "flakes"];
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "26.05"; # Did you read the comment?

}
