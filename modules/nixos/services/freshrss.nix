{config, ...}: {
  services.freshrss = {
    enable = true;
    api.enable = true;
    defaultUser = "willow";
    passwordFile = config.age.secrets.freshrss.file;
    webserver = "caddy";
    database = {
      type = "sqlite";
    };
  };

  services.caddy.enable = true;
}
