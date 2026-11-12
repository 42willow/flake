{
  pkgs,
  inputs,
  config,
  lib,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];

  options.programs.niri.enable = lib.options.mkEnableOption "niri";

  config = lib.modules.mkIf config.programs.niri.enable {
    niri-flake.cache.enable = true;
    nixpkgs.overlays = [inputs.niri.overlays.niri];

    # build first with niri disabled, then enable after cache is added
    programs.niri = {
      enable = true;
      package = pkgs.niri-unstable;
    };
  };
}
