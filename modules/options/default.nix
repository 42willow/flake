{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;

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
            default = cfg.programs.enable;
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
        dev.enable =
          mkEnableOption "Enable development programs"
          // {
            default = cfg.programs.categories.enable;
          };
        fs.enable =
          mkEnableOption "Enable file management programs"
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
        social.enable =
          mkEnableOption "Enable social media programs"
          // {
            default = cfg.programs.categories.enable;
          };
        printing.enable =
          mkEnableOption "Enable 3D printing programs"
          // {
            default = cfg.programs.categories.enable;
          };
        tools.enable =
          mkEnableOption "Enable QOL programs"
          // {
            default = cfg.programs.categories.enable;
          };
        web = {
          enable =
            mkEnableOption "Enable browsers"
            // {
              default = cfg.programs.categories.enable;
            };
          chromium.enable =
            mkEnableOption "Enable Chromium"
            // {
              default = cfg.programs.categories.web.enable;
            };
          firefox.enable =
            mkEnableOption "Enable Firefox"
            // {
              default = cfg.programs.categories.web.enable;
            };
          floorp.enable =
            mkEnableOption "Enable Floorp"
            // {
              default = false;
            };
          tor.enable =
            mkEnableOption "Enable Tor"
            // {
              default = cfg.programs.categories.web.enable;
            };
          zen.enable =
            mkEnableOption "Enable Zen"
            // {
              default = cfg.programs.categories.web.enable;
            };
        };
      };
    };
    system = {
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
      hyprland.enable =
        mkEnableOption "Enable Hyprland and its ecosystem"
        // {
          default = cfg.programs.gui.enable;
        };
    };
  };
}
