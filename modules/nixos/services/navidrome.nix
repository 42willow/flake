{
  config,
  lib,
  ...
}: let
  cfg = config.settings.system.services.navidrome;
in {
  config = lib.mkIf cfg.enable {
    users.groups.music = {};

    systemd.services.navidrome.serviceConfig.ProtectHome = lib.mkForce "read-only";

    services.navidrome = {
      enable = true;
      openFirewall = true;

      user = "navidrome";
      group = "music";

      settings = {
        # TODO: use this value for beets
        MusicFolder = "${config.settings.system.user.home}/media/music";
        Address = "0.0.0.0";
      };
    };
  };
}
