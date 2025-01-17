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
    # ./nvim
    ./bat.nix # core
    ./btop.nix # core
    ./gitui.nix # dev
    ./lazygit.nix # dev
    ./ncmpcpp.nix # music
    ./yazi.nix # files
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
