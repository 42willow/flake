{
  config,
  lib,
  self,
  ...
}: let
  inherit (self.lib) mkSecret mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.junimoserver;
in {
  options.nest.services.junimoserver = mkServiceOption "sdv" {
    port = 5800; # todo use this for the VNC session
    tailnet = true;
  };

  config = mkIf cfg.enable {
    sops = {
      secrets = {
        junimoserver-steam-username = mkSecret {
          file = "junimoserver";
          key = "steam/username";
        };
        junimoserver-steam-password = mkSecret {
          file = "junimoserver";
          key = "steam/password";
        };
        junimoserver-vnc_password = mkSecret {
          file = "junimoserver";
          key = "vnc_password";
        };
        junimoserver-api_key = mkSecret {
          file = "junimoserver";
          key = "api_key";
        };
      };
      templates.junimoserver-env.content = with config.sops.placeholder; ''
        STEAM_USERNAME=${junimoserver-steam-username}
        STEAM_PASSWORD=${junimoserver-steam-password}
        VNC_PASSWORD=${junimoserver-vnc_password}
        API_KEY=${junimoserver-api_key}
      '';
    };

    virtualisation.oci-containers.containers.junimoserver = {
      image = "sdvd/server:latest";
      autoStart = true;

      environmentFiles = [config.sops.templates.junimoserver-env.path];

      environment = {
        TZ = "Australia/Melbourne";
        SERVER_FPS = "5";
      };

      volumes = [
        "/var/lib/junimoserver/saves:/home/steam/.config/StardewValley"
        "/var/lib/junimoserver/game:/home/steam/stardewvalley"
        "/var/lib/junimoserver/steam:/home/steam/Steam"
      ];

      # no host ports published - players join via Steam invite code
      # Adjust ports to match the image's exposed game/VNC/web ports
      # ports = [
      #   "24642:24642"
      #   "24642:24642/udp"
      # ];
      # Only bind VNC web UI (5800) to host loopback (7981); 24642 stays unexposed
      ports = [
        "${cfg.host}:${toString cfg.port}:5800"
      ];
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/junimoserver 0755 root root -"
      "d /var/lib/junimoserver/saves 0775 1000 1000 -"
      "d /var/lib/junimoserver/game 0775 1000 1000 -"
      "d /var/lib/junimoserver/steam 0775 1000 1000 -"
    ];
  };
}
