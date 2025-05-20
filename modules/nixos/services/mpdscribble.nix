{
  config,
  lib,
  ...
}: let
  cfg = config.settings.programs.categories.music;
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
