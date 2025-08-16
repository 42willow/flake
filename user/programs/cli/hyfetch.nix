{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.tools.enable) {
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "rainbow";
        lightness = 0.8;
        backend = "fastfetch";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
      };
    };
    home.packages = [
      pkgs.fastfetch
    ];
  };
}
