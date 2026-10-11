{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;

  cfg = config.settings;
in {
  options.nest = {
    profiles = {
      graphical
    }
    programs = {
      enable =
        mkEnableOption "Enable all programs"
        // {default = true;};

      cli.enable =
        mkEnableOption "Enable CLI and TUI programs"
        // {default = cfg.programs.enable;};
      gui.enable =
        mkEnableOption "Enable GUI programs"
        // {default = cfg.desktop.enable;};
    };

    system = {
      user = {
        name = mkOption {
          type = types.str;
          description = "The username of the main user for your system";
          default = "willow";
        };
        home = mkOption {
          type = types.path;
          description = "The home directory of the main user for your system";
          default = "/home/${cfg.system.user.name}";
        };
        group = mkOption {
          type = types.str;
          description = "The group of the main user for your system";
          default = "users";
        };
        flakeDir = mkOption {
          type = types.path;
          description = "The directory of this flake, used for symlinks";
          default = "${cfg.system.user.home}/flake";
        };
      };

      hostName = mkOption {
        type = types.str;
        description = "The hostname of your system";
        default = "nixos";
      };

      services = {
        enable =
          mkEnableOption "Enable system services"
          // {default = true;};
        bluetooth.enable =
          mkEnableOption "Enable Bluetooth"
          // {default = cfg.system.services.enable;};
        sound.enable =
          mkEnableOption "Enable sound"
          // {default = cfg.system.services.enable;};
        sync = {
          enable =
            mkEnableOption "Enable syncthing"
            // {default = false;};
          key = lib.mkOption {type = lib.types.path;};
          cert = lib.mkOption {type = lib.types.path;};
        };
        printing.enable =
          mkEnableOption "Enable printing"
          // {default = cfg.system.services.enable;};
        networking.enable =
          mkEnableOption "Enable networking"
          // {default = cfg.system.services.enable;};
        security.enable =
          mkEnableOption "Enable security"
          // {default = cfg.system.services.enable;};
        backups.enable =
          mkEnableOption "Enable restic"
          // {default = false;};
      };
    };

    desktop = {
      enable =
        mkEnableOption "Enable desktop environment"
        // {default = true;};
      niri.enable =
        mkEnableOption "Enable Niri twm"
        // {default = cfg.desktop.enable;};
    };
  };
}
