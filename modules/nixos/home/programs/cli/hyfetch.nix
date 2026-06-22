{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf cfg.cli {
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
