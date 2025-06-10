{
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hyprland.org/Configuring/Window-Rules/

    windowrulev2 = [
      "float,class:(KeePassXC)"
      "float,class:(qalculate-qt)"
    ];

    # See https://wiki.hyprland.org/Configuring/Workspace-Rules/

    workspace = [
      "special:scratchpad, on-created-empty:ghostty, gapsout:50"
      "special:btop, on-created-empty:ghostty -e btop, gapsout:50"
      "special:mpd, on-created-empty:ghostty -e ncmpcpp, gapsout:50"
    ];
  };
}
