{
  lib,
  self,
  config,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.uhf-server;
in {
  options.nest.services.uhf-server = mkServiceOption "uhf server" {
    port = 8000;
    tailnet = false;
  };

  config = mkIf cfg.enable {
    virtualisation.oci-containers.containers.uhf-server = {
      image = "swapplications/uhf-server:2.2.0";
      autoStart = true;
      ports = ["${cfg.host}:${toString cfg.port}:8000"];
      volumes = [
        "/var/lib/uhf/recordings:/recordings"
      ];
      environment = {
        PORT = "8000"; # internal
        ENABLE_COMMERCIAL_DETECTION = "true";
      };
      cmd = ["uhf-server"];
    };

    systemd.tmpfiles.rules = [
      "d /var/lib/uhf/recordings 0755 root root - -"
    ];

    networking.firewall.allowedTCPPorts = [cfg.port];
  };
}
