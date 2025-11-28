{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) optionals concatLists;
  cfg = osConfig.settings.programs;
in {
  imports = [
    # ./lazygit.nix # dev
    ./ncmpcpp.nix
    ./yazi.nix
  ];

  config = lib.mkIf cfg.tui.enable {
    home.packages = with pkgs;
      concatLists [
        (optionals cfg.categories.tools.enable [
          peaclock
        ])
      ];
  };
}
