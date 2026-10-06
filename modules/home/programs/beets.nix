{
  lib,
  osConfig,
  config,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
  inherit (pkgs) stdenv;

  musicDir = "/srv/music";
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.music.enable) {
    systemd.user.services.mpdstats =
      lib.mkIf (stdenv.isLinux
        && config.services.mpd.enable)
      {
        Unit = {
          Description = "Beets MPDStats daemon";
          Requires = ["mpd.service"];
          After = ["mpd.service"];
        };

        Install.WantedBy = ["default.target"];

        Service = {
          ExecStart = "${config.programs.beets.package}/bin/beet mpdstats";
          Restart = "on-failure";
        };
      };

    programs.beets = {
      enable = true;
      mpdIntegration.enableUpdate = true;
      settings = {
        plugins = [
          "musicbrainz"
          "fetchart"
          "thumbnails"
          "mbsync"
          "edit"
          "inline"
        ];
        directory = "${musicDir}";
        library = "${musicDir}/music_library.db";
        import = {
          copy = true;
          write = true;
          autotag = true;
        };

        # plugin: inline
        item_fields = {
          multidisc = "1 if disctotal > 1 else 0";
        };

        # aunique and sunique are important but shouldn't really ever be used
        paths = let
          album = "[$year] $album ($format)%aunique{}/%if{$multidisc,disc $disc/}$track - $title";
        in {
          default = "artists/$albumartist/albums/${album}";
          singleton = "artists/$artist/singles/$title%sunique{}";
          comp = "compilations/${album}";
        };

        fetchart = {
          auto = true;
          sources = [
            "filesystem"
            "amazon"
            "itunes"
            "coverart"
            "albumart"
          ];
        };
      };
    };
  };
}
