{
  lib,
  pkgs,
  config,
  ...
}: let
  wpctl = lib.getExe' pkgs.wireplumber "wpctl";
in {
  programs.niri.settings.binds =
    {
      # === Actions ====
      "Mod+Shift+Slash".action.show-hotkey-overlay = [];
      "Mod+B".action.power-off-monitors = [];

      "Mod+C".action.close-window = [];
      "Mod+Escape".action.toggle-overview = [];

      "Mod+Shift+Q".action.quit = [];

      "Print".action.screenshot = [];
      "Mod+Print".action.screenshot-screen = [];
      "Alt+Print".action.screenshot-window = [];

      # ==== Spawn ====
      "Mod+F".action.spawn = "firefox";
      "Mod+L".action.spawn = lib.getExe config.programs.hyprlock.package;
      "Mod+P".action.spawn = lib.getExe pkgs.kooha;
      "Mod+Q".action.spawn = lib.getExe config.programs.ghostty.package;
      "Mod+W".action.spawn = lib.getExe pkgs.vesktop;
      "Mod+X".action.spawn = "zed-editor";
      "Mod+Space".action.spawn = ["${lib.getExe' pkgs.tofi "tofi-drun"}" "--drun-launch=true" "--fuzzy-match=true"];

      # ==== Windows ====
      "Mod+N".action.focus-column-left = [];
      "Mod+E".action.focus-workspace-down = [];
      "Mod+I".action.focus-workspace-up = [];
      "Mod+O".action.focus-column-right = [];
      "Mod+A".action.focus-column-left = [];
      "Mod+R".action.focus-workspace-down = [];
      "Mod+S".action.focus-workspace-up = [];
      "Mod+T".action.focus-column-right = [];

      "Alt+N".action.move-column-left = [];
      "Alt+E".action.move-column-to-workspace-down = [];
      "Alt+I".action.move-column-to-workspace-up = [];
      "Alt+O".action.move-column-right = [];
      "Alt+A".action.move-column-left = [];
      "Alt+R".action.move-column-to-workspace-down = [];
      "Alt+S".action.move-column-to-workspace-up = [];
      "Alt+T".action.move-column-right = [];

      "Mod+Comma".action.consume-window-into-column = [];
      "Mod+Period".action.expel-window-from-column = [];

      "Mod+M".action.maximize-column = [];

      "Mod+WheelScrollDown" = {
        cooldown-ms = 150;
        action.focus-workspace-down = [];
      };
      "Mod+WheelScrollUp" = {
        cooldown-ms = 150;
        action.focus-workspace-up = [];
      };
      "Alt+WheelScrollDown" = {
        cooldown-ms = 150;
        action.move-column-to-workspace-down = [];
      };
      "Alt+WheelScrollUp" = {
        cooldown-ms = 150;
        action.move-column-to-workspace-up = [];
      };

      # === Sound ====
      XF86AudioRaiseVolume = {
        allow-when-locked = true;
        action.spawn = [
          wpctl
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.05+"
          "-l"
          "1.0"
        ];
      };
      XF86AudioLowerVolume = {
        allow-when-locked = true;
        action.spawn = [
          wpctl
          "set-volume"
          "@DEFAULT_AUDIO_SINK@"
          "0.05-"
        ];
      };
      XF86AudioMute = {
        allow-when-locked = true;
        action.spawn = [
          wpctl
          "set-mute"
          "@DEFAULT_AUDIO_SINK@"
          "toggle"
        ];
      };
      XF86AudioMicMute = {
        allow-when-locked = true;
        action.spawn = [
          wpctl
          "set-mute"
          "@DEFAULT_AUDIO_SOURCE@"
          "toggle"
        ];
      };
    }
    // lib.foldl' (
      attr: i:
        attr
        // {
          "Mod+${toString i}".action.focus-workspace = i;
          "Alt+${toString i}".action.move-window-to-workspace = i;
        }
    ) {} (lib.range 1 9);
}
