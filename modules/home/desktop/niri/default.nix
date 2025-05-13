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
      gaps = 0;
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

        active.color = "#b4befe";
        inactive.color = "#1e1e2e";
      };
      focus-ring.enable = false;
      insert-hint.display.color = "#b4befe80";
    };
  };
}
