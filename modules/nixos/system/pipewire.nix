{
  config,
  pkgs,
  lib,
  ...
}: {
  config = lib.mkIf config.nest.hardware.sound.enable {
    # enable sound with pipewire
    services.pulseaudio.enable = false;
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
