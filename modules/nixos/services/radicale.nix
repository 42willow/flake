{config, ...}: {
  services.tailscale.serve.services.radicale = {
    advertised = true;
    endpoints = {
      "tcp:443" = "http://127.0.0.1:5232";
    };
  };

  services.radicale = {
    enable = true;
    settings = {
      server = {
        hosts = ["127.0.0.1:5232"];
      };
      auth = {
        type = "htpasswd";
        htpasswd_filename = config.age.secrets.radicaleUsers.path;
        htpasswd_encryption = "bcrypt";
      };
      storage = {
        filesystem_folder = "/var/lib/radicale/collections";
      };
    };
  };
}
