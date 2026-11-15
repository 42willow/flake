{
  lib,
  self,
  config,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf types;
  inherit (lib.options) mkOption;

  cfg = config.nest.services.calibre-server;
  inherit (cfg) ebooksPath;
in {
  options.nest.services.calibre-server =
    mkServiceOption "calibre" {
      port = 4321;
      tailnet = true;
    }
    // {
      ebooksPath = mkOption {
        type = types.str;
        default = "/srv/ebooks";
        description = "Path to the ebooks directory.";
      };
    };

  config = mkIf cfg.enable {
    services.calibre-server = {
      enable = true;
      openFirewall = false;
      inherit (cfg) port;
      host = cfg.host;
      user = "calibre-server";
      group = "calibre-server";

      libraries = [ebooksPath];
    };

    systemd.tmpfiles.rules = [
      "d ${ebooksPath} 0777 willow users -"
    ];
  };
}
