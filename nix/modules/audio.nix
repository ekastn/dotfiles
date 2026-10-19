{ config, pkgs, ... }:

{
  # T480 (ALC257, SSID 17aa:225d): keep internal mic selectable while a
  # TRRS headset is plugged in. dell-headset-multi disables jack-detect
  # on the external-mic pins so both inputs stay visible. Revert by
  # removing this block. Alternatives: headset-mode, headset-mic,
  # dell-headset4, auto.
  boot.extraModprobeConfig = ''
    options snd-hda-intel model=dell-headset-multi
  '';

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;

    extraConfig.pipewire."99-lowlatency" = {
      "context.properties" = {
        "default.clock.rate" = 48000;
        "default.clock.allowed-rates" = [ 44100 48000 88200 96000 ];
        "default.clock.quantum" = 128;
        "default.clock.min-quantum" = 64;
        "default.clock.max-quantum" = 512;
      };
    };
  };

  environment.variables = {
    LADSPA_PATH = "$HOME/.ladspa:/run/current-system/sw/lib/ladspa";
    LV2_PATH = "$HOME/.lv2:/run/current-system/sw/lib/lv2";
    VST3_PATH = "$HOME/.vst3:/run/current-system/sw/lib/vst3";
    CLAP_PATH = "$HOME/.clap:/run/current-system/sw/lib/clap";
  };

  environment.systemPackages = with pkgs; [
    lsp-plugins
    distrho-ports
    vital
    surge-xt
    ladspaPlugins
    tap-plugins
    caps
    rnnoise-plugin.ladspa
    rubberband
  ];
}
