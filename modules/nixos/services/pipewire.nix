{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.settings.services.pipewire;
in {
  options.settings.services.pipewire = {
    enable =
      lib.mkEnableOption "Pipewire"
      // {
        default = config.settings.services.enable;
        defaultText = lib.literalExpression "Whether to enable pipewire support";
      };
  };

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

    environment.systemPackages = with pkgs; [
      pavucontrol
    ];
  };
}
