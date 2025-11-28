{
  lib,
  inputs,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib) optionals concatLists;
  cfg = osConfig.settings.programs;
in {
  imports = [
    ./git.nix
  ];

  config = lib.mkIf cfg.cli.enable {
    home.packages = with pkgs;
    with inputs;
      concatLists [
        (optionals cfg.categories.dev.enable [
          # python
          uv
        ])
      ];
  };
}
