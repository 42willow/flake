{
  lib,
  osConfig,
  pkgs,
  inputs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  imports = [
    ./terminals
    ./zathura.nix
  ];

  config = lib.mkIf cfg.gui.enable {
    home.packages = [
      inputs.chiri.packages.${pkgs.stdenv.hostPlatform.system}.default
    ];
  };
}
