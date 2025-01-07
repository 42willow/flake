{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.willow.desktop.hyprland;
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

  options.willow.desktop.hyprland = {
    enable =
      lib.mkEnableOption "Enable Hyprland"
      // {
        default = config.willow.desktop.enable;
      };
  };

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
