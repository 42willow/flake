{
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.jellyfin;
in {
  options.nest.services.jellyfin = mkServiceOption "jellyfin" {
    port = 8096;
    tailnet = true;
  };

  config = mkIf cfg.enable {
    services.jellyfin = {
      enable = true;
      openFirewall = true;
    };

    systemd.services.jellyfin.environment = {
      JELLYFIN_HTTP_PORT = toString cfg.port;
      JELLYFIN_BIND_IP = cfg.host;
    };
  };
}
