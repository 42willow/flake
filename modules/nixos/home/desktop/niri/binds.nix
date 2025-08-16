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
      # ==== Actions ====
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
      "Mod+Q".action.spawn = lib.getExe config.programs.alacritty.package;
      "Mod+T".action.spawn = lib.getExe pkgs.vesktop;
      "Mod+W".action.spawn = "nautilus";
      "Mod+X".action.spawn = "zeditor";
      "Mod+Space".action.spawn = ["${lib.getExe' pkgs.tofi "tofi-drun"}" "--drun-launch=true" "--fuzzy-match=true"];

      # ==== Windows ====
      "Mod+N".action.focus-column-or-monitor-left = [];
      "Mod+E".action.focus-window-or-workspace-down = [];
      "Mod+I".action.focus-window-or-workspace-up = [];
      "Mod+O".action.focus-column-or-monitor-right = [];
      "Mod+Shift+WheelScrollUp".action.focus-column-or-monitor-left = [];
      "Mod+WheelScrollDown".action.focus-window-or-workspace-down = [];
      "Mod+WheelScrollUp".action.focus-window-or-workspace-up = [];
      "Mod+Shift+WheelScrollDown".action.focus-column-or-monitor-right = [];

      "Alt+N".action.move-column-left-or-to-monitor-left = [];
      "Alt+E".action.move-window-down-or-to-workspace-down = [];
      "Alt+I".action.move-window-up-or-to-workspace-up = [];
      "Alt+O".action.move-column-right-or-to-monitor-right = [];
      "Alt+Shift+WheelScrollUp".action.move-column-left-or-to-monitor-left = [];
      "Alt+WheelScrollDown".action.move-window-down-or-to-workspace-down = [];
      "Alt+WheelScrollUp".action.move-window-up-or-to-workspace-up = [];
      "Alt+Shift+WheelScrollDown".action.move-column-right-or-to-monitor-right = [];

      "Mod+Shift+N".action.focus-monitor-left = [];
      "Mod+Shift+O".action.focus-monitor-right = [];
      "Mod+MouseBack".action.focus-monitor-left = [];
      "Mod+MouseForward".action.focus-monitor-right = [];

      "Alt+Shift+N".action.move-workspace-to-monitor-left = [];
      "Alt+Shift+E".action.move-workspace-down = [];
      "Alt+Shift+I".action.move-workspace-up = [];
      "Alt+Shift+O".action.move-workspace-to-monitor-right = [];
      "Alt+MouseBack".action.move-workspace-to-monitor-left = [];
      "Alt+MouseForward".action.move-workspace-to-monitor-right = [];

      "Mod+Comma".action.consume-window-into-column = [];
      "Mod+Period".action.expel-window-from-column = [];

      "Mod+R".action.switch-preset-column-width = [];
      "Alt+R".action.switch-preset-window-height = [];
      "Mod+S".action.maximize-column = [];
      "Alt+S".action.reset-window-height = [];

      # === Special Keys ====
      XF86MonBrightnessUp = {
        cooldown-ms = 50;
        action.spawn = [
          "brightnessctl"
          "set"
          "+5%"
        ];
      };
      XF86MonBrightnessDown = {
        cooldown-ms = 50;
        action.spawn = [
          "brightnessctl"
          "set"
          "5%-"
        ];
      };
      XF86AudioRaiseVolume = {
        allow-when-locked = true;
        cooldown-ms = 50;
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
        cooldown-ms = 50;
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
      XF86AudioPlay = {
        allow-when-locked = true;
        action.spawn = [
          "playerctl"
          "play-pause"
        ];
      };
      XF86AudioPause = {
        allow-when-locked = true;
        action.spawn = [
          "playerctl"
          "play-pause"
        ];
      };
      XF86AudioNext = {
        allow-when-locked = true;
        action.spawn = [
          "playerctl"
          "next"
        ];
      };
      XF86AudioPrev = {
        allow-when-locked = true;
        action.spawn = [
          "playerctl"
          "previous"
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
