{
  config,
  lib,
  ...
}: let
  inherit (lib) mkOption types recursiveUpdate;

  # base config for desktop and server profiles
  # the default (no profile) is just the defaults outlined in the options
  base = {
    programs = {
      enable = lib.mkDefault true;
      cli = lib.mkDefault true;
      terminal = {
        shell = {
          atuin.enable = true;
          starship.enable = true;
          zsh.enable = lib.mkDefault true;
          userShell = "zsh";
        };
        tools.enable = lib.mkDefault true;
      };
    };
    services = {
      enable = lib.mkDefault true;
      networking.enable = lib.mkDefault true;
    };
  };

  profiles = {
    desktop = recursiveUpdate base {
      programs = {
        gui = lib.mkDefault true;

        games.enable = lib.mkDefault true;
        media.enable = lib.mkDefault true;
        productivity.enable = lib.mkDefault true;
        social.enable = lib.mkDefault true;

        browsers = {
          helium.enable = lib.mkDefault true;
          firefox.enable = lib.mkDefault true;
          chromium.enable = lib.mkDefault true;
        };

        terminal = {
          emulator.ghostty.enable = lib.mkDefault true;
        };
      };
      services = {
        enable = lib.mkDefault true;
        bluetooth.enable = lib.mkDefault true;
        printing.enable = lib.mkDefault true;
        sound.enable = lib.mkDefault true;
      };
      desktop = {
        enable = lib.mkDefault true;
        niri.enable = lib.mkDefault true;
      };
    };

    server = recursiveUpdate base {
      services.ssh.enable = lib.mkDefault true;
    };
  };
in {
  options.profile = mkOption {
    type = types.nullOr (types.enum ["desktop" "server"]);
    default = null;
    description = "The system profile preset to apply. If null, the system falls back to the minimal defaults.";
  };

  config.nest =
    if config.profile != null
    then profiles.${config.profile}
    else {};
}
