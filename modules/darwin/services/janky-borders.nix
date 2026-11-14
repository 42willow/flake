{
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.jankyborders;
in {
  options.nest.services.jankyborders = mkServiceOption "jankyborders" {};

  config = mkIf cfg.enable {
    services.jankyborders = {
      enable = false;

      width = 6.0;
      hidpi = true;
      active_color = "0xFFf5bde6";
      inactive_color = "0x001e2030";
    };
  };
}
