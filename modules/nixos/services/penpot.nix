{
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.penpot;
in {
  options.nest.services.penpot = mkServiceOption "penpot" {
    port = 9001;
    tailnet = true;
  };

  config = mkIf cfg.enable {
    # sops.secrets = foodogsquaredLib.sops-nix.getSecrets ./secrets.yaml {
    #   "penpot/env" = {};
    #   "penpot/postgres_env" = {};
    # };

    virtualisation.oci-containers = {
      networks.penpot = {};

      volumes = {
        penpot_assets = {};
        penpot_postgres_v15 = {};
      };

      containers = {
        penpot-frontend = {
          image = "docker.io/penpotapp/frontend:latest";
          dependsOn = ["penpot-backend" "penpot-exporter"];
          ports = lib.singleton "${cfg.host}:${toString cfg.port}:9001";
          extraOptions = ["--network=penpot"];
          volumes = ["penpot_assets:/opt/data/assets"];
          environment.PENPOT_FLAGS = lib.concatStringsSep " " [
            "enable-login-with-password"
            "enable-webhooks"
            "enable-login-with-github"
            "enable-login-with-oidc"
            "disable-registration"
          ];
        };
        penpot-backend = {
          image = "docker.io/penpotapp/backend:latest";
          volumes = ["penpot_assets:/opt/data/assets"];
          extraOptions = ["--network=penpot"];
          dependsOn = ["penpot-postgres" "penpot-redis"];
          environmentFiles = [config.sops.secrets."penpot/env".path];
          environment = {
            PENPOT_FLAGS = lib.concatStringsSep " " [
              "enable-registration"
              "enable-login-with-password"
            ];
            PENPOT_PUBLIC_URI = "http://localhost:${toString cfg.port}";
            PENPOT_DATABASE_URI = "postgresql://penpot-postgres/penpot";
            PENPOT_REDIS_URI = "redis://penpot-redis/0";
            PENPOT_ASSETS_STORAGE_BACKEND = "assets-fs";
            PENPOT_STORAGE_ASSETS_FS_DIRECTORY = "/opt/data/assets";
            PENPOT_TELEMETRY_ENABLED = "true";
          };
        };
        penpot-exporter = {
          image = "docker.io/penpotapp/exporter:latest";
          extraOptions = ["--network=penpot"];
          environment = {
            PENPOT_PUBLIC_URI = "http://penpot-frontend";
            PENPOT_REDIS_URI = "redis://penpot-redis/0";
          };
        };
        penpot-redis = {
          image = "docker.io/redis:7";
          extraOptions = ["--network=penpot"];
        };
        penpot-postgres = {
          image = "docker.io/postgres:15";
          volumes = ["penpot_postgres_v15:/var/lib/postgresql/data"];
          extraOptions = ["--network=penpot"];
          environmentFiles = [config.sops.secrets."penpot/postgres_env".path];
          environment = {
            POSTGRES_INITDB_ARGS = lib.concatStringsSep " " ["--data-checksums"];
            POSTGRES_DB = "penpot";
          };
        };
      };
    };
  };
}
