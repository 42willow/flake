{
  pkgs,
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.syncthing;
in {
  options.nest.services.syncthing = mkServiceOption "syncthing" {};

  config = mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      package = pkgs.unstable.syncthing;
      guiAddress = "127.0.0.1:8384";
      # sudo tailscale serve --bg http://127.0.0.1:8384

      inherit (cfg) key cert;
      overrideFolders = false;
      overrideDevices = false;

      settings = {
        gui = {
          insecureSkipHostCheck = true;
        };
        options = {
          # disable discovery, relays, and NAT traversal (tailscale only)
          globalAnnounceEnabled = false;
          localAnnounceEnabled = false;
          relaysEnabled = false;
          natEnabled = false;

          urAccepted = -1; # disable usage reporting
        };
      };
    };
  };
}
