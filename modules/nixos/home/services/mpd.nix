{
  pkgs,
  config,
  lib,
  self,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.mpd;
in {
  options.nest.services.mpd = mkServiceOption "mpd" {};

  config = mkIf cfg.enable {
    services = {
      mpd = {
        enable = true;
        musicDirectory = "${config.xdg.userDirs.music}";
        dataDir = "${config.xdg.configHome}/mpd";
        network.startWhenNeeded = true;
        extraConfig = ''
          audio_output {
            type "pipewire"
            name "PipeWire"
          }
          audio_output {
            type "fifo"
            name "Visualiser"
            path "/tmp/mpd.fifo"
            format "44100:16:2"
          }
        '';
      };

      mpd-discord-rpc = {
        enable = true;
        package = pkgs.unstable.mpd-discord-rpc;
        settings = {
          format = {
            details = "$title";
            state = "$artist";
            large_text = "$album";
            small_text = "Listening to $genre music with MPD ^-^";
          };
        };
      };

      # Bridge between MPD and MPRIS
      mpdris2 = {
        enable = true;
        notifications = true;
      };
    };
  };
}
