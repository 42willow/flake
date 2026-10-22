{
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkSecret mkServiceOption;
  inherit (lib) toString mkIf;

  cfg = config.nest.services.radicale;
in {
  options.nest.services.radicale = mkServiceOption "radicale" {
    port = 5232;
    tailnet = true;
  };

  config = mkIf cfg.enable {
    sops = {
      secrets.radicale-willow = mkSecret {
        file = "radicale";
        key = "willow";
      };
      templates.radicale-htpasswd = {
        content = with config.sops.placeholder; ''
          willow:${radicale-willow}
        '';
        owner = "radicale";
        group = "radicale";
        mode = "0440";
      };
    };

    services.radicale = {
      enable = true;
      user = "radicale";
      group = "radicale";
      settings = {
        server.hosts = ["${cfg.host}:${toString cfg.port}" "[::]:${toString cfg.port}"];
        auth = {
          type = "htpasswd";
          htpasswd_filename = config.sops.templates.radicale-htpasswd.path;
          htpasswd_encryption = "bcrypt";
        };
        storage = {
          filesystem_folder = "/var/lib/radicale/collections";
        };
      };
    };
  };
}
