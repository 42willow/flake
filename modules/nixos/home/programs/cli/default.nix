{
  inputs,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) optionals concatLists;
  cfg = osConfig.settings.programs;
in {
  imports = [
    ./beets.nix
    ./direnv.nix
    ./hyfetch.nix
    ./nushell.nix
  ];
  config = lib.mkIf cfg.cli.enable {
    home.packages = with pkgs;
    with inputs;
      concatLists [
        (optionals cfg.categories.tools.enable [
          brightnessctl
          ddcutil
          grim
          killall
          playerctl
          slurp
          wl-clipboard
        ])
        (optionals cfg.categories.dev.enable [
          # nix
          nix-output-monitor
        ])
      ];
  };
}
