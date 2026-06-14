{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types;

  profiles = {
    desktop = {
      programs = {
        enable = lib.mkDefault true;
        cli = lib.mkDefault true;
        gui = lib.mkDefault true;

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
      };
    };
  };
in {
  options.nest.profile = mkOption {
    type = types.nullOr (types.enum ["desktop" "server"]);
    default = null;
    description = "The system profile preset to apply. If null, the system falls back to the minimal defaults.";
  };

  config.nest =
    if config.nest.profile != null
    then profiles.${config.nest.profile}
    else {};
}
