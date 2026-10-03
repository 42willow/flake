{
  config,
  self,
  ...
}: let
  inherit (self.lib) mkSecret;

  domain = "earthy.raccoon-gourami.ts.net";
  baseUrl = "https://${domain}";
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
    inherit baseUrl;
    api.enable = true;
    defaultUser = "willow";
    passwordFile = config.sops.secrets.freshrss-password.path;
    webserver = "caddy";
    database = {
      type = "sqlite";
    };
  };
}
