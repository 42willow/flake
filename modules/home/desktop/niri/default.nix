{
  inputs,
  pkgs,
  osConfig,
  lib,
  config,
  ...
}: {
  # imports = [
  #   inputs.niri.homeModules.niri
  # ];

  programs.niri.settings = {
    animations.enable = true;
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
        # layout = "us";
        # variant = "colemak";
        inherit (osConfig.services.xserver.xkb) layout variant options;
      };
    };
    binds = {
      "Mod+Shift+Slash".action.show-hotkey-overlay = [];
      "Mod+B".action.power-off-monitors = [];

      "Mod+F".action.spawn = "firefox";
      "Mod+L".action.spawn = "hyprlock";
      "Mod+Q".action.spawn = "ghostty";
      "Mod+R".action.spawn = lib.getExe pkgs.kooha;
      "Mod+T".action.spawn = "vesktop";
      "Mod+X".action.spawn = "zeditor";
      "Mod+Space".action.spawn = ["tofi-drun" "--drun-launch=true" "--fuzzy-match=true"];

      "Mod+N".action.focus-column-left = [];
      "Mod+E".action.focus-window-down = [];
      "Mod+I".action.focus-window-up = [];
      "Mod+O".action.focus-column-right = [];

      "Mod+C".action.close-window = [];
      "Mod+Escape".action.toggle-overview = [];

      "Mod+Shift+Q".action.quit = [];

      "Mod+WheelScrollDown" = {
        cooldown-ms = 150;
        action.focus-workspace-down = [];
      };
      "Mod+WheelScrollUp" = {
        cooldown-ms = 150;
        action.focus-workspace-up = [];
      };
      "Mod+Ctrl+WheelScrollDown" = {
        cooldown-ms = 150;
        action.move-column-to-workspace-down = [];
      };
      "Mod+Ctrl+WheelScrollUp" = {
        cooldown-ms = 150;
        action.move-column-to-workspace-up = [];
      };
    };
  };
}
