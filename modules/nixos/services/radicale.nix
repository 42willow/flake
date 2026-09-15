{config, ...}: {
  # this is done imperatively at the moment
  # sudo tailscale serve --service=svc:radicale --bg http://127.0.0.1:5232
  services.tailscale.serve.services.radicale = {
    advertised = true;
    endpoints = {
      # TODO tcp:443 has no TLS termination - tailscale/tailscale#19724
      "tcp:80" = "http://127.0.0.1:5232";
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
