{
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hyprland.org/Configuring/

    monitor = [
      "DP-1, preferred, 0x0, 1.5"
      "DP-2, preferred, 0x0, 1.5"
      "eDP-1, preferred, 2560x0, 1"
      # "eDP-1, disabled"
      # "DP-1, 2560x1440, 0x0, 1"
      # "DP-2, 2560x1440, 0x0, 1"
      # "eDP-1, 1920x1080, 2560x0, 1"
      # "DP-1, 1920x1080, 0x0, 1"
      # "eDP-1, 1920x1080, 1920x0, 1"
    ];

    xwayland.force_zero_scaling = true;

    input = {
      kb_layout = "us,us";
      kb_variant = "colemak,";
      kb_options = "grp:alt_space_toggle, caps:backspace, shift:both_capslock_cancel";
      follow_mouse = 1;
      touchpad = {
        disable_while_typing = false;
        natural_scroll = true;
        scroll_factor = 0.8;
      };
      sensitivity = 0.5; # -1.0 - 1.0, 0 means no modification.
      numlock_by_default = true;
    };

    general = {
      gaps_in = 5;
      gaps_out = 12;
      border_size = 3;
      "col.active_border" = "$pink $blue 45deg";
      "col.inactive_border" = "$mantle";
      layout = "dwindle";
    };

    decoration = {
      rounding = 10;
      blur.enabled = false;
      shadow.enabled = false;
    };

    animations = {
      enabled = true;
      bezier = [
        "linear, 0.0, 0.0, 1.0, 1.0"
        "easeOutBack, 0.34, 1.3, 0.64, 1"
        "easeOutExpo, 0.16, 1, 0.3, 1"
        "popIn, 0.05, 0.9, 0.1, 1.05"
      ];
      animation = [
        "windows, 1, 5, easeOutBack"
        "windowsOut, 0, 5, default, ease"
        "border, 1, 5, default"
        "borderangle, 1, 30, linear, loop"
        "fade, 1, 2, default"
        "workspaces, 1, 3, default"
      ];
    };

    dwindle = {
      # See https://wiki.hyprland.org/Configuring/Dwindle-Layout/
      pseudotile = true;
      preserve_split = true;
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_fingers = 3;
    };

    misc = {
      mouse_move_enables_dpms = true;
      middle_click_paste = false;
      disable_hyprland_logo = true; # disables hyprland background entirely
    };
  };
}
