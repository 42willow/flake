{
  lib,
  config,
  ...
}: let
  cfg = config.nest;

  profiles = {
    # defaults from options.nix
    minimal = {
      programs = {
        enable = lib.mkDefault true;
        cli = lib.mkDefault true;
      };
      system.services = {
        enable = lib.mkDefault true;
        networking.enable = lib.mkDefault true;
      };
    };

    desktop = {
      programs = {
        enable = lib.mkDefault true;
        # we are already grouping for cli or gui which i prefer over grouping
        # by categories as that is already the file tree and cant have both
        # as the options are hierarchical
        cli.enable = lib.mkDefault true;
        gui.enable = lib.mkDefault true;

        games.enable = lib.mkDefault true;
        media.enable = lib.mkDefault true;
        productivity.enable = lib.mkDefault true;
        social.enable = lib.mkDefault true;
        browsers = {
          helium.enable = lib.mkDefault true;
          firefox.enable = lib.mkDefault true;
        };

        terminal = {
          emulator.ghostty.enable = lib.mkDefault true;
          shell = {
            zsh.enable = lib.mkDefault true;
            userShell = "zsh";
          };
          tools.enable = lib.mkDefault true;
        };
      };
      system.services = {
        enable = lib.mkDefault true;
        backups.enable = lib.mkDefault true;
        bluetooth.enable = lib.mkDefault true;
        networking.enable = lib.mkDefault true;
        printing.enable = lib.mkDefault true;
        sound.enable = lib.mkDefault true;
      };
      desktop = {
        enable = lib.mkDefault true;
        niri.enable = lib.mkDefault true;
      };
    };

    server = {
      programs = {
        enable = lib.mkDefault true;
        cli = lib.mkDefault true;

        terminal = {
          shell = {
            zsh.enable = lib.mkDefault true;
            userShell = "zsh";
          };
        };
      };

      system.services = {
        enable = lib.mkDefault true;
        networking.enable = lib.mkDefault true;
        ssh.enable = lib.mkDefault true;
        # TODO backups and config for them
      };
    };
  };
in {
  config.settings = profiles.${cfg.profile} or {};
}
