{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.nest.services.pipewire;
in {
  options.nest.services.pipewire = {
    enable =
      lib.mkEnableOption "Pipewire"
      // {
        default = config.nest.services.enable;
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
