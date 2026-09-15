{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.system.services.sync;
in {
  config = lib.mkIf cfg.enable {
    services.syncthing = {
      enable = true;
      package = pkgs.unstable.syncthing;
      guiAddress = "127.0.0.1:8384";
      # sudo tailscale serve --bg http://127.0.0.1:8384

      inherit (cfg) key cert;
      overrideFolders = false;
      overrideDevices = false;

      settings = {
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
