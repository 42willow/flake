{
  self,
  config,
  ...
}: let
  inherit (self.lib) mkSecret;

  domain = "freshrss.raccoon-gourami.ts.net";
  port = 8443;
in {
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
    virtualHost = "http://${domain}:${toString port}";
    database.type = "sqlite";
    api.enable = true;
  };

  services.caddy = {
    enable = true;

    virtualHosts.${config.services.freshrss.virtualHost}.extraConfig = ''
      bind 0.0.0.0
    '';
  };

  # https://tailscale.com/docs/integrations/web-servers/caddy/caddy-certificates
  # permit the caddy user to request certificates from the tailscale socket
  systemd.services.tailscaled.environment = {
    TS_PERMIT_CERT_UID = "caddy";
  };
}
