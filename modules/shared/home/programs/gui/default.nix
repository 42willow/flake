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

  config = {
    # targets.darwin.linkApps.enable = false;
    # targets.darwin.copyApps.enable = true;

    # home.packages = [
    #   inputs.chiri.packages.${pkgs.stdenv.hostPlatform.system}.default
    # ];
  };
}
