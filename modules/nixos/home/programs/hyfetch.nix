{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.hyfetch = {
    settings = {
      preset = "nonbinary";
      lightness = 0.5;
      mode = "rgb";
      color_align.mode = "horizontal";
      backend = "fastfetch";
      pride_month_disable = false;
    };
  };
  home.packages = lib.mkIf config.programs.hyfetch.enable [
    pkgs.fastfetch
  ];
}
