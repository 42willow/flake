{
  config,
  lib,
  pkgs,
  self,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.tailscale;
in {
  options.nest.services.tailscale = mkServiceOption "tailscale" {};

  config = mkIf cfg.enable {
    services.tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      openFirewall = true;
      extraSetFlags = [
        "--advertise-exit-node"
        "--advertise-routes=10.10.1.0/24"
      ];
      useRoutingFeatures = "both";
    };

    # disable firewall for tailscale
    networking.firewall.trustedInterfaces = [config.services.tailscale.interfaceName];

    /*
    configure tailscale serve
    `services.tailscale.serve.services.<name>` doesn't work with https
    see https://github.com/tailscale/tailscale/issues/18381
    */
    systemd.services.tailscale-serve = {
      description = "configure tailscale serve";
      after = ["tailscaled.service" "tailscaled.socket" "network-online.target"];
      wants = ["tailscaled.service" "tailscaled.socket" "network-online.target"];
      wantedBy = ["multi-user.target"];
      stopIfChanged = false;

      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };

      script = let
        ts = lib.getExe config.services.tailscale.package;
      in ''
        echo "waiting for tailscaled backend to be ready"
        until ${ts} status --json | ${pkgs.jq}/bin/jq -e '.BackendState == "Running"' >/dev/null 2>&1; do
          sleep 1
        done
        echo "tailscaled backend is ready"

        ${ts} serve reset

        ${lib.concatStringsSep "\n" (
          lib.mapAttrsToList (
            _: svc: "${ts} serve --service=${svc.tailnet.name} ${toString svc.port}"
          ) (
            lib.filterAttrs (
              _: svc: svc.enable && svc.tailnet.enable
            )
            config.nest.services
          )
        )}

        ${ts} serve --bg 8384
      '';
    };
  };
}
