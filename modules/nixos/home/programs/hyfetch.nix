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
        preset = "nonbinary";
        lightness = 0.5;
        mode = "rgb";
        color_align.mode = "horizontal";
        backend = "fastfetch";
        pride_month_disable = false;
      };
    };
    home.packages = [
      pkgs.fastfetch
    ];
  };
}
