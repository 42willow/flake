{
  self,
  config,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.mpdscribble;
in {
  options.nest.services.mpdscribble = mkServiceOption "mpdscribble" {};

  config = mkIf cfg.enable {
    services.mpdscribble = {
      enable = false;
      endpoints."last.fm" = {
        # passwordFile = config.sops.secrets.lastfm.path;
        username = "snudoo";
      };
    };
  };
}
