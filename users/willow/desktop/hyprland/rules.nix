{...}: {
  wayland.windowManager.hyprland.settings = {
    # See https://wiki.hyprland.org/Configuring/Window-Rules/

    windowrulev2 = [
      "float,class:(KeePassXC)"
      "float,class:(speedcrunch)"
    ];

    # See https://wiki.hyprland.org/Configuring/Workspace-Rules/

    workspace = [
      "special:scratchpad, on-created-empty:kitty, gapsout:50"
      "special:btop, on-created-empty:kitty btop, gapsout:50"
      "special:mpd, on-created-empty:kitty ncmpcpp, gapsout:50"
    ];
  };
}
