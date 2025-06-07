{
  pkgs,
  inputs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.desktop;
in {
  imports = [inputs.stylix.homeModules.stylix];

  config = lib.mkIf cfg.enable {
    stylix = {
      enable = true;
      autoEnable = false;

      targets = {
        gtk.enable = true;
      };

      override = {
        base0D = "f5bde6";
      };

      # https://tinted-theming.github.io/base16-gallery/
      base16Scheme = let
        theme = "catppuccin-macchiato";
      in "${pkgs.base16-schemes}/share/themes/${theme}.yaml";

      cursor = {
        package = pkgs.catppuccin-cursors.macchiatoDark;
        name = "catppuccin-macchiato-dark-cursors";
        size = 24;
      };

      image = "${inputs.wallpapers.packages.${pkgs.system}.macchiato}/share/wallpapers/macchiato/images/art/kurzgesagt/on_a_moon.png";
    };
  };
}
