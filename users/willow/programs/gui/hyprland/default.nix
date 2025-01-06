{...}: {
  imports = [
    ./binds.nix
    ./rules.nix
    ./settings.nix
    ./env.nix
    ./autostart.nix
    ./hyprpaper.nix
    ./hyprlock.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
  };
}
