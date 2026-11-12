{
  config,
  inputs,
  pkgs,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.gammastep;
in {
  options.nest.services.gammastep = mkServiceOption "gammastep" {};

  config = mkIf cfg.enable {
    services.gammastep = {
      enable = true;
      tray = true;
      provider = "manual";
      latitude = -38.0;
      longitude = 145.0;
      settings.general.adjustment-method = "wayland";
    };
  };
}
