{
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.gatus;
  mkTailnetEndpoint = {
    name,
    subdomain,
    path ? "",
    port ? null,
  }:
    assert port == null || builtins.isInt port; let
      portSuffix =
        if builtins.isInt port
        then ":${toString port}"
        else "";
    in {
      inherit name;
      group = "tailnet";
      url = "https://${subdomain}.raccoon-gourami.ts.net${portSuffix}${path}";
      interval = "30s";
      conditions = [
        "[STATUS] == 200"
        "[RESPONSE_TIME] < 300"
      ];
    };
in {
  options.nest.services.gatus = mkServiceOption "gatus" {
    port = 3001;
    tailnet = true;
  };

  config = mkIf cfg.enable {
    services.gatus = {
      enable = true;
      settings = {
        web.port = cfg.port;
        endpoints = [
          (mkTailnetEndpoint {
            name = "immich - photos";
            subdomain = "immich";
            path = "/api/server/ping";
          })
          (mkTailnetEndpoint {
            name = "jellyfin - media server";
            subdomain = "jellyfin";
            path = "/health";
          })
          (mkTailnetEndpoint {
            name = "radicale - CalDAV";
            subdomain = "radicale";
          })
          (mkTailnetEndpoint {
            name = "dispatcharr - IPTV & EPG";
            subdomain = "dispatcharr";
          })
          (mkTailnetEndpoint {
            name = "home assistant";
            subdomain = "homeassistant";
          })
          {
            name = "syncthing - starling";
            subdomain = "starling";
            group = "tailnet";
            url = "https://starling.raccoon-gourami.ts.net";
            interval = "30s";
            conditions = [
              "[STATUS] == 200"
            ];
          }
          {
            name = "syncthing - earthy";
            subdomain = "earthy";
            group = "tailnet";
            url = "http://localhost:8384";
            interval = "30s";
            conditions = [
              "[STATUS] == 200"
              "[RESPONSE_TIME] < 500"
            ];
          }

          # {
          #   name = "northsky.social";
          #   group = "external";
          #   url = "https://northsky.social/xrpc/_health";
          #   interval = "5m";
          #   conditions = [
          #     "[STATUS] == 200"
          #     "has([BODY].version) == true"
          #     "[RESPONSE_TIME] < 2000"
          #   ];
          # }
          # {
          #   name = "tech.lgbt";
          #   group = "external";
          #   url = "https://tech.lgbt/health";
          #   interval = "5m";
          #   conditions = [
          #     "[STATUS] == 200"
          #     "[BODY] == OK"
          #     "[RESPONSE_TIME] < 2000"
          #   ];
          # }
        ];
      };
    };
  };
}
