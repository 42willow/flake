{
  config,
  self,
  ...
}: let
  inherit (self.lib) mkSecret;
in {
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
      server = {
        hosts = ["0.0.0.0:5232" "[::]:5232"];
      };
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
}
