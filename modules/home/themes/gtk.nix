{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.desktop;
in {
  config = lib.mkIf cfg.enable {
    gtk = {
      enable = true;
      iconTheme = {
        name = "Papirus-Dark";
        package = pkgs.catppuccin-papirus-folders.override {
          flavor = "macchiato";
          accent = "pink";
        };
      };
    };
  };
}
