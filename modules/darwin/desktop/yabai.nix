{
  services.yabai = {
    enable = true;
    enableScriptingAddition = true;

    config = {
      focus_follows_mouse = "autoraise";

      mouse_modifier = "cmd";
      mouse_action1 = "move";
      mouse_action2 = "resize";

      layout = "bsp";

      top_padding = 12;
      bottom_padding = 12;
      left_padding = 12;
      right_padding = 12;

      window_gap = 12;
      window_shadow = "off";
    };
  };
}
