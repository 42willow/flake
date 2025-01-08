{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.desktop.hyprland;
in {
  imports = [
    ./binds.nix
    ./rules.nix
    ./settings.nix
    ./env.nix
    ./autostart.nix
    ./hyprpaper.nix
    ./hyprlock.nix
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
