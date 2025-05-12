{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.dev.enable) {
    # programs.helix = {
    #   enable = true;
    #   defaultEditor = true;
    # };
    home.packages = [pkgs.helix];
  };
}
