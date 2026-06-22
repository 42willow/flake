{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.nest.desktop;
in {
  imports = [inputs.niri.nixosModules.niri];

  config = lib.mkIf (cfg.enable && cfg.niri.enable) {
    niri-flake.cache.enable = true;
    nixpkgs.overlays = [inputs.niri.overlays.niri];

    # build first with niri disabled, then enable after cache is added
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
  };
}
