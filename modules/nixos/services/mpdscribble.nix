{
  config,
  lib,
  ...
}: let
  cfg = config.settings.programs.categories.music;
in {
  config = lib.mkIf cfg.enable {
    services.mpdscribble = {
      enable = false;
      endpoints."last.fm" = {
        # passwordFile = config.sops.secrets.lastfm.path;
        username = "snudoo";
      };
    };
  };
}
