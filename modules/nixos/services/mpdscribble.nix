{
  config,
  lib,
  ...
}: let
  cfg = config.nest.services.selfhost.mpd;
in {
  config = lib.mkIf cfg.enable {
    services.mpdscribble = {
      enable = true;
      endpoints."last.fm" = {
        passwordFile = config.age.secrets.lastfm.path;
        username = "snudoo";
      };
    };
  };
}
