{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  cfg = osConfig.nest.desktop.hyprland;
in {
  imports = [
    ./autostart.nix
    ./binds.nix
    ./env.nix
    ./hypridle.nix
    ./hyprlock.nix
    ./hyprpaper.nix
    ./rules.nix
    ./settings.nix
  ];

  config = lib.mkIf cfg.enable {
    wayland.windowManager.hyprland = {
      enable = true;
    };

    home.packages = with pkgs; [
      hypridle
      hyprpicker
      hyprcursor
    ];
  };
}
