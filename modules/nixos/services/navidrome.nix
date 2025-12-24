{
  config,
  lib,
  ...
}: let
  cfg = config.settings.system.services.navidrome;
in {
  config = lib.mkIf cfg.enable {
    services.navidrome = {
      enable = true;
      openFirewall = true;

      settings = {
        # TODO: use this value for beets
        MusicFolder = "${config.settings.user.home}/media/music/music";
      };
    };
  };
}
