{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;

  cfg = config.settings;
in {
  options.settings = {
    programs = {
      enable =
        mkEnableOption "Enable all programs"
        // {
          default = true;
        };

      cli = {
        enable =
          mkEnableOption "Enable CLI programs"
          // {
            default = cfg.programs.enable;
          };
      };
      gui = {
        enable =
          mkEnableOption "Enable GUI programs"
          // {
            default = cfg.desktop.enable;
          };
      };
      tui = {
        enable =
          mkEnableOption "Enable TUI programs"
          // {
            default = cfg.programs.enable;
          };
      };

      categories = {
        enable =
          mkEnableOption "Enable all program categories"
          // {
            default = cfg.programs.enable;
          };
        core.enable =
          mkEnableOption "Enable core programs"
          // {
            default = cfg.programs.categories.enable;
          };
        design.enable =
          mkEnableOption "Enable design programs"
          // {
            default = cfg.programs.categories.enable;
          };
        dev.enable =
          mkEnableOption "Enable development programs"
          // {
            default = cfg.programs.categories.enable;
          };
        edu.enable =
          mkEnableOption "Enable educational programs"
          // {
            default = cfg.programs.categories.enable;
          };
        fs.enable =
          mkEnableOption "Enable file management programs"
          // {
            default = cfg.programs.categories.enable;
          };
        fun.enable =
          mkEnableOption "Enable fun programs"
          // {
            default = cfg.programs.categories.enable;
          };
        gaming.enable =
          mkEnableOption "Enable gaming programs"
          // {
            default = cfg.programs.categories.enable;
          };
        mail.enable =
          mkEnableOption "Enable email programs"
          // {
            default = cfg.programs.categories.enable;
          };
        media.enable =
          mkEnableOption "Enable multimedia programs"
          // {
            default = cfg.programs.categories.enable;
          };
        music.enable =
          mkEnableOption "Enable music programs"
          // {
            default = cfg.programs.categories.enable;
          };
        printing.enable =
          mkEnableOption "Enable 3D printing programs"
          // {
            default = cfg.programs.categories.enable;
          };
        privacy.enable =
          mkEnableOption "Enable privacy programs"
          // {
            default = cfg.programs.categories.enable;
          };
        tools.enable =
          mkEnableOption "Enable QOL programs"
          // {
            default = cfg.programs.categories.enable;
          };
        web.enable =
          mkEnableOption "Enable browsers"
          // {
            default = cfg.programs.categories.enable;
          };
      };
    };
    system = {
      mainUser = mkOption {
        type = types.str;
        description = "The username of the main user for your system";
        default = "willow";
      };
      bluetooth.enable =
        mkEnableOption "Enable Bluetooth"
        // {
          default = true;
        };
      sound.enable =
        mkEnableOption "Enable sound"
        // {
          default = true;
        };
      printing.enable =
        mkEnableOption "Enable printing"
        // {
          default = true;
        };
      networking.enable =
        mkEnableOption "Enable networking"
        // {
          default = true;
        };
      security.enable =
        mkEnableOption "Enable security"
        // {
          default = true;
        };
    };
    desktop = {
      enable =
        mkEnableOption "Enable desktop environment"
        // {
          default = true;
        };
      hyprland.enable =
        mkEnableOption "Enable Hyprland and its ecosystem"
        // {
          default = cfg.desktop.enable;
        };
    };
  };
}
