{
  osConfig,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.core.enable) {
    home.packages = [
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    qt.enable = true;
  };
}
