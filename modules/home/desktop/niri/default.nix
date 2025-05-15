{
  pkgs,
  osConfig,
  config,
  lib,
  ...
}: {
  imports = [
    ./binds.nix
  ];

  programs.niri.settings = {
    animations.enable = true;
    prefer-no-csd = true;

    cursor = {
      inherit (config.stylix.cursor) size;
      theme = config.stylix.cursor.name;
    }; # TODO)) this doesn't fix the big cursor issue

    outputs = let
      default = {
        backdrop-color = "#1e2030";
      };
    in {
      DP-1 =
        default
        // {
          position = {
            x = 0;
            y = 0;
          };
        };
      DP-2 =
        default
        // {
          position = {
            x = 0;
            y = 0;
          };
        };
      eDP-1 =
        default
        // {
          scale = 1;
          position = {
            x = 2560;
            y = 0;
          };
        };
    };
    window-rules = [
      {
        geometry-corner-radius = let
          radius = 8.0;
        in {
          bottom-left = radius;
          bottom-right = radius;
          top-left = radius;
          top-right = radius;
        };
        clip-to-geometry = true;
      }
      # {
      #   # screencasted windows
      #   matches = [{is-window-cast-target = true;}];
      #   border = {
      #     active-color = "#ed8796";
      #   };
      # }
    ];
    spawn-at-startup = [
      {
        command = [(lib.getExe pkgs.xwayland-satellite-unstable)];
      }
    ];
    environment = {
      DISPLAY = ":0"; # xwayland-satellite
    };

    input = {
      keyboard.xkb = {
        inherit (osConfig.services.xserver.xkb) layout variant options;
      };
    };

    screenshot-path = "${config.xdg.userDirs.pictures}/screenshots/screenshot-%Y-%m-%d_%H:%M:%S.png";

    layout = {
      gaps = 5;
      center-focused-column = "never";

      preset-column-widths = [
        {proportion = 1.0 / 3.0;}
        {proportion = 1.0 / 2.0;}
        {proportion = 2.0 / 3.0;}
      ];
      default-column-width.proportion = 0.5;

      border = {
        enable = true;
        width = 2;

        active.color = "#f5bde6";
        inactive.color = "#24273a";
      };
      focus-ring.enable = false;
      insert-hint.display.color = "#f5bde680";
    };
  };
}
