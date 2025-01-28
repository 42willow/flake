{
  inputs,
  pkgs,
  ...
}: {
  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [
        "${inputs.wallpapers.packages.${pkgs.system}.macchiato}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_1.png"
        "${inputs.wallpapers.packages.${pkgs.system}.macchiato}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_2.png"
      ];
      wallpaper = [
        "eDP-1, ${inputs.wallpapers.packages.${pkgs.system}.macchiato}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_1.png"
        "DP-1, ${inputs.wallpapers.packages.${pkgs.system}.macchiato}/share/wallpapers/macchiato/images/art/kurzgesagt/black_hole_2.png"
      ];
      splash = false;
    };
  };
}
