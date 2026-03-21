{inputs, ...}: {
  imports = [
    inputs.paneru.homeModules.paneru
  ];

  services.paneru = {
    enable = true;

    settings = {
      options = {
        preset_column_widths = [
          0.33
          0.5
          0.66
        ];
        animation_speed = 100;
        # sliver_height = 0.5;
      };
      swipe = {
        gesture = {
          fingers_count = 3;
          direction = "Natural";
        };
        deceleration = 10;
      };
      padding = {
        top = 10;
        bottom = 10;
        left = 10;
        right = 10;
      };

      bindings = {
        window_focus_west = "alt - n";
        window_focus_south = "alt - e";
        window_focus_north = "alt - i";
        window_focus_east = "alt - o";

        # window_swap_west = "alt - n";
        # window_swap_east = "alt - o";
        # window_swap_first = "alt + shift - n";
        # window_swap_last = "alt + shift - o";

        # window_center = "alt - c";
        window_resize = "alt - s";
        window_fullwidth = "alt - f";
        # window_manage = "ctrl + alt - t";
        # window_stack = "alt - ,";
        # window_unstack = "alt + .";
        # quit = "ctrl + alt - q";
      };

      windows.all = {
        title = ".*";
        horizontal_padding = 5;
      };

      # decorations.active.border = {
      #   enabled = true;
      #   color = "#f5bde6";
      # };
    };
  };
}
