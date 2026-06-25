{
  lib,
  config,
  pkgs,
  inputs,
  ...
}: let
  cfg = config.settings.programs;
in {
  config = lib.mkIf cfg.gui.enable {
    environment.systemPackages = [
      inputs.chiri.packages.${pkgs.stdenv.hostPlatform.system}.source
      pkgs.unstable.aseprite
    ];
  };
}
