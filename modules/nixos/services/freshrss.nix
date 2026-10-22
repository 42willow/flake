{
  self,
  config,
  lib,
  ...
}: let
  inherit (self.lib) mkSecret mkServiceOption;

  domain = "freshrss.raccoon-gourami.ts.net";
  inherit (lib) mkIf;

  cfg = config.nest.services.freshrss;
in {
  options.nest.services.freshrss = mkServiceOption "freshrss" {port = 8443;};

  config = mkIf cfg.enable {
    sops.secrets.freshrss-password = mkSecret {
      file = "freshrss";
      key = "password";
      owner = "freshrss";
      group = "freshrss";
      mode = "0440";
    };

    services.freshrss = {
      enable = true;
      defaultUser = "willow";
      passwordFile = config.sops.secrets.freshrss-password.path;
      webserver = "caddy";
      baseUrl = "https://${domain}";
      virtualHost = "http://${domain}:${toString cfg.port}";
      database.type = "sqlite";
      api.enable = true;
    };

    services.caddy = {
      enable = true;
      virtualHosts.${config.services.freshrss.virtualHost}.extraConfig = ''
        bind ${cfg.host}
      '';
    };

    # https://tailscale.com/docs/integrations/web-servers/caddy/caddy-certificates
    # permit the caddy user to request certificates from the tailscale socket
    systemd.services.tailscaled.environment = {
      TS_PERMIT_CERT_UID = "caddy";
    };
  };
}
