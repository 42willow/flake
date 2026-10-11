{
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkSecret mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.freshrss;

  domain = "earthy.raccoon-gourami.ts.net"; # TODO set in options
  baseUrl = "https://${domain}";
in {
  options.nest.services.freshrss = mkServiceOption "freshrss" {port = 4110;};

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
      inherit baseUrl;
      api.enable = true;
      defaultUser = "willow";
      passwordFile = config.sops.secrets.freshrss-password.path;
      webserver = "caddy";
      database = {
        type = "sqlite";
      };
    };
  };
}
