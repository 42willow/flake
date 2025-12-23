{
  lib,
  osConfig,
  config,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
  inherit (pkgs) stdenv;
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
          "fetchart"
          "thumbnails"
          "mbsync"
          "edit"
        ];
        directory = "${config.xdg.userDirs.music}/music";
        library = "${config.xdg.userDirs.music}/music_library.db";
        import = {
          copy = true;
          write = true;
          autotag = true;
        };
        paths = {
          default = "Albums/%upper{%left{$albumartist,1}}/$albumartist/$album%aunique{}/$track. $title";
          singleton = "Singles/$artist/$title";
          comp = "Compilations/$album%aunique{}/$track. $title";
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
