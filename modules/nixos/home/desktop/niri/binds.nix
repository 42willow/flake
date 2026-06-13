{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  cfg = osConfig.settings.desktop.niri;
  wpctl = lib.getExe' pkgs.wireplumber "wpctl";
in {
  config = lib.mkIf cfg.enable {
    programs.niri.settings.binds = with config.lib.niri.actions;
      {
        # ==== Actions ====
        "Mod+Shift+Slash" = show-hotkey-overlay;
        "Mod+B" = power-off-monitors;

        "Mod+C" = close-window;
        "Mod+Escape" = toggle-overview;

        "Mod+Shift+Q" = quit;

        "Print" = screenshot;
        "Mod+Print" = screenshot-screen;
        "Alt+Print" = screenshot-window;

        # ==== Spawn ====
        "Mod+F" = spawn "firefox";
        # "Mod+L" = spawn  lib.getExe config.programs.hyprlock.package;
        "Mod+P" = spawn (lib.getExe pkgs.kooha);
        "Mod+Q" = spawn (lib.getExe config.programs.alacritty.package);
        "Mod+T" = spawn (lib.getExe pkgs.vesktop);
        "Mod+W" = spawn "nautilus";
        "Mod+X" = spawn "zeditor";
        "Mod+Space" = spawn (lib.getExe' pkgs.tofi "tofi-drun") "--drun-launch=true" "--fuzzy-match=true";

        # ==== Windows ====
        "Mod+N" = focus-column-or-monitor-left;
        "Mod+E" = focus-window-or-workspace-down;
        "Mod+I" = focus-window-or-workspace-up;
        "Mod+O" = focus-column-or-monitor-right;
        "Mod+Shift+WheelScrollUp" = focus-column-or-monitor-left;
        "Mod+WheelScrollDown" = focus-window-or-workspace-down;
        "Mod+WheelScrollUp" = focus-window-or-workspace-up;
        "Mod+Shift+WheelScrollDown" = focus-column-or-monitor-right;

        "Alt+N" = move-column-left-or-to-monitor-left;
        "Alt+E" = move-window-down-or-to-workspace-down;
        "Alt+I" = move-window-up-or-to-workspace-up;
        "Alt+O" = move-column-right-or-to-monitor-right;
        "Alt+Shift+WheelScrollUp" = move-column-left-or-to-monitor-left;
        "Alt+WheelScrollDown" = move-window-down-or-to-workspace-down;
        "Alt+WheelScrollUp" = move-window-up-or-to-workspace-up;
        "Alt+Shift+WheelScrollDown" = move-column-right-or-to-monitor-right;

        "Mod+Shift+N" = focus-monitor-left;
        "Mod+Shift+O" = focus-monitor-right;
        "Mod+MouseBack" = focus-monitor-left;
        "Mod+MouseForward" = focus-monitor-right;

        "Alt+Shift+N" = move-workspace-to-monitor-left;
        "Alt+Shift+E" = move-workspace-down;
        "Alt+Shift+I" = move-workspace-up;
        "Alt+Shift+O" = move-workspace-to-monitor-right;
        "Alt+MouseBack" = move-workspace-to-monitor-left;
        "Alt+MouseForward" = move-workspace-to-monitor-right;

        "Mod+Comma" = consume-window-into-column;
        "Mod+Period" = expel-window-from-column;

        "Mod+R" = switch-preset-column-width;
        "Alt+R" = switch-preset-window-height;
        "Mod+S" = maximize-column;
        "Alt+S" = reset-window-height;

        # === Special Keys ====
        XF86MonBrightnessUp = {
          cooldown-ms = 50;
          action = spawn "brightnessctl" "set" "+5%";
        };
        XF86MonBrightnessDown = {
          cooldown-ms = 50;
          action = spawn "brightnessctl" "set" "5%-";
        };
        XF86AudioRaiseVolume = {
          allow-when-locked = true;
          cooldown-ms = 50;
          action = spawn wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05+" "-l" "1.0";
        };
        XF86AudioLowerVolume = {
          allow-when-locked = true;
          cooldown-ms = 50;
          action = spawn wpctl "set-volume" "@DEFAULT_AUDIO_SINK@" "0.05-";
        };
        XF86AudioMute = {
          allow-when-locked = true;
          action = spawn wpctl "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle";
        };
        XF86AudioMicMute = {
          allow-when-locked = true;
          action = spawn wpctl "set-mute" "@DEFAULT_AUDIO_SOURCE@" "toggle";
        };
        XF86AudioPlay = {
          allow-when-locked = true;
          action = spawn "playerctl" "play-pause";
        };
        XF86AudioPause = {
          allow-when-locked = true;
          action = spawn "playerctl" "play-pause";
        };
        XF86AudioNext = {
          allow-when-locked = true;
          action = spawn "playerctl" "next";
        };
        XF86AudioPrev = {
          allow-when-locked = true;
          action = spawn "playerctl" "previous";
        };
      }
      // lib.foldl' (
        attr: i:
          attr
          // {
            "Mod+${toString i}" = focus-workspace i;
            "Alt+${toString i}" = move-window-to-workspace i;
          }
      ) {} (lib.range 1 9);
  };
}
