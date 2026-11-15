{
  pkgs,
  lib,
  self,
  config,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.actual;
in {
  options.nest.services.actual = mkServiceOption "actual" {
    port = 5006;
    tailnet = true;
  };

  config = mkIf cfg.enable {
    services.actual = {
      enable = true;
      package = pkgs.unstable.actual-server;
      openFirewall = false;

      settings = {
        inherit (cfg) port;
        hostname = cfg.host;
      };
    };
  };
}
