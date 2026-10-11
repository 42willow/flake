{
  pkgs,
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.immich;
in {
  options.nest.services.immich = mkServiceOption "immich" {
    port = 2283;
    tailnet = true;
  };

  config = mkIf cfg.enable {
    services.immich = {
      inherit (cfg) host port;
      enable = true;
      package = pkgs.unstable.immich;
      openFirewall = false;
    };
  };
}
