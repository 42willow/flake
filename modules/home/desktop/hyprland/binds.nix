{
  wayland.windowManager.hyprland.settings = {
    binds = {
      scroll_event_delay = 0; # default: 300
    };
    # See https://wiki.hyprland.org/Configuring/Binds/

    # l -> locked, will also work when an input inhibitor (e.g. a lockscreen) is active.
    # r -> release, will trigger on release of a key.
    # e -> repeat, will repeat when held.
    # n -> non-consuming, key/mouse events will be passed to the active window in addition to triggering the dispatcher.
    # m -> mouse, see below.
    # t -> transparent, cannot be shadowed by other binds.
    # i -> ignore mods, will ignore modifiers.
    # s -> separate, will arbitrarily combine keys between each mod/key, see [Keysym combos](#keysym-combos) above.
    # d -> has description, will allow you to write a description for your bind.
    # p -> bypasses the app's requests to inhibit keybinds.

    "$mod" = "SUPER";
    "$altMod" = "ALT";
    "$sudoMod" = "SUPER SHIFT";

    # Mouse bindings
    bindm = [
      "$mod, mouse:272, movewindow"
      "$mod, mouse:273, resizewindow"
    ];

    # Repeating bindings
    bindle = [
      ", xf86audioraisevolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
      ", xf86audiolowervolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ", xf86audiomute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ", xf86monbrightnessup, exec, brightnessctl set +5%"
      ", xf86monbrightnessdown, exec, brightnessctl set 5%-"
    ];

    # Always-on bindings
    bindl = [
      ", xf86display, exec, hyprctl dispatch dpms off"
      ", xf86audioplay, exec, playerctl play-pause"
      ", xf86audiopause, exec, playerctl play-pause"
      ", xf86audionext, exec, playerctl next"
      ", xf86audioprev, exec, playerctl previous"

      "$mod, B, exec, hyprctl dispatch dpms off"
    ];

    # Normal bindings
    bind =
      [
        ", xf86wlan, exec, nmcli radio wifi toggle"
        # ", xf86tools, exec, /home/willow/.dotfiles/tofi/power_menu.sh" # TODO))
        ", xf86bluetooth, exec, bluetoothctl power toggle"
        # ", xf86keyboard, exec, hyprctl keyword input:kb_variant colemak" # TODO)) choose another bind
        ", xf86favorites, exec, hyprctl dispatch pin"
        ", xf86audiomicmute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"
        ", xf86calculator, exec, speedcrunch"
        # ~ Executables ~
        # TODO))
        # "$mod, Print, exec, ~/.config/hypr/scripts/screen.sh"
        # "$altMod, Print, exec, ~/.config/hypr/scripts/screen.sh audio"
        # "$altMod, C, exec, ~/.config/hypr/scripts/hyprpicker.sh"
        # "mod, V, exec, ~/.config/hypr/scripts/clipboard.sh"
        # "altMod, V, exec, cliphist wipe && dunstify \"󱘘 Clipboard history cleared\""
        # "mod, code:60, exec, rofimoji"

        ", Print, exec, grim -g \"$(slurp -d -c f5bde6)\" - | wl-copy"
        "$mod, space, exec, tofi-drun --drun-launch=true --fuzzy-match=true"
        "$mod, Q, exec, kitty"
        "$mod, F, exec, zen"
        "$mod, E, exec, nautilus"
        "$mod, X, exec, zeditor"
        "$mod, L, exec, hyprlock"
        "$mod, P, exec, hyprctl dispatch pin"

        # ~ Windows ~

        "$mod, C, killactive"
        "$mod, S, togglefloating"
        "$mod, Z, alterzorder, bottom"
        "$mod, D, layoutmsg, togglesplit"
        # "$mod, F11, fullscreenstate, -1 2" # fake fullscreen

        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$altMod, left, movewindow, l"
        "$altMod, right, movewindow, r"
        "$altMod, up, movewindow, u"
        "$altMod, down, movewindow, d"

        # ~ Workspaces ~

        "$mod, mouse_up, workspace, e-1"
        "$mod, mouse_down, workspace, e+1"
        "$mod, code:49, togglespecialworkspace, scratchpad" # code:49 = `
        "$altMod, code:49, movetoworkspace, special:scratchpad" # code:49 = `
        "$mod, code:20, togglespecialworkspace, scratchpad_alt" # code:20 = -
        "$altMod, code:20, movetoworkspace, special:scratchpad_alt" # code:20 = -
        "$mod, A, togglespecialworkspace, mpd"
        "$altMod, A, movetoworkspace, special:mpd"
        "$mod, escape, togglespecialworkspace, btop"

        # ~ Sudo mods ~

        # "$sudoMod, R, exec, ~/.config/hypr/scripts/reload.sh" TODO))
        # "$sudoMod, P, exec, ~/.config/tofi/scripts/power_menu.sh" # TODO))
        "$sudoMod, M, exit"
        "$sudoMod, S, exec, kitty --hold nh os switch"
      ]
      ++ (
        # binds $mod + [shift +] {1..9} to [move to] workspace {1..9}
        builtins.concatLists (builtins.genList (
            x: let
              ws = builtins.toString (x + 1);
            in [
              "$mod, ${ws}, workspace, ${toString (x + 1)}"
              "$altMod, ${ws}, movetoworkspace, ${toString (x + 1)}"
            ]
          )
          9)
      );
  };
}
