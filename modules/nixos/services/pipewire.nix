{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.settings.system.services.sound;
in {
  config = lib.mkIf cfg.enable {
    # Enable sound with pipewire
    hardware.pulseaudio.enable = false;
    security.rtkit.enable = true; # optional but recommended
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };

    environment.systemPackages = [pkgs.pavucontrol];
  };
}
