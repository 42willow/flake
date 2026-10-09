{
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.dispatcharr;
in {
  options.nest.services.dispatcharr = mkServiceOption "dispatcharr" {
    port = 3005;
    tailnet = true;
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.backend = "podman"; # TODO move elsewhere

    virtualisation.oci-containers.containers.dispatcharr = {
      image = "ghcr.io/dispatcharr/dispatcharr:latest";
      autoStart = true;
      ports = ["${cfg.host}:${toString cfg.port}:9191"];
      environment = {
        DISPATCHARR_ENV = "aio";
        REDIS_HOST = "localhost";
        CELERY_BROKER_URL = "redis://localhost:6379/0";
        DISPATCHARR_LOG_LEVEL = "info";
      };
      volumes = [
        "/var/lib/dispatcharr:/data"
        "/home/willow/epg:/epg" # TODO
      ];
      extraOptions = [
        "--device=/dev/dri:/dev/dri" # Intel GPU for VA-API
      ];
    };
    systemd.tmpfiles.rules = [
      "d /var/lib/dispatcharr 0755 root root - -"
      "d /home/willow/epg 0755 willow users - -"
    ];
  };
}
