{config, ...}: let
  domain = "earthy.raccoon-gourami.ts.net";
  baseUrl = "https://${domain}";
in {
  services.freshrss = {
    enable = true;
    inherit baseUrl;
    api.enable = true;
    defaultUser = "willow";
    passwordFile = config.age.secrets.freshrss.file;
    webserver = "caddy";
    database = {
      type = "sqlite";
    };
  };

  services.caddy = {
    enable = true;
    virtualHosts.${domain}.extraConfig = ''
      tls {
        get_certificate tailscale
      }
    '';
  };
}
