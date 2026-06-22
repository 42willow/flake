{
  osConfig,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf cfg.gui {
    home.packages = [
      inputs.quickshell.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
    qt.enable = true;
  };
}
