{
  inputs,
  pkgs,
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.settings.desktop.hyprland;
in {
  config = lib.mkIf cfg.enable {
    services.hyprpaper = {
      enable = true;
      settings = let
        walls = inputs.wallpapers.packages.${pkgs.stdenv.hostPlatform.system}.macchiato;
      in {
        preload = [
          "${walls}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_1.png"
          "${walls}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_2.png"
        ];
        wallpaper = [
          "eDP-1, ${walls}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_1.png"
          "DP-1, ${walls}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_2.png"
          "DP-2, ${walls}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_2.png"
        ];
        splash = false;
      };
    };
  };
}
