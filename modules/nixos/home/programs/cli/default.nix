{
  inputs,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) optionals;
  cfg = osConfig.nest;
in {
  imports = [
    ./hyfetch.nix
    ./ncmpcpp.nix
    ./nushell.nix
    ./yazi.nix
    ./lazygit.nix
  ];
  config = lib.mkIf cfg.programs.cli {
    home.packages = with pkgs;
    with inputs;
      (optionals cfg.programs.devtools.enable [
        nix-output-monitor
      ])
      ++ optionals cfg.desktop.enable [
        brightnessctl
        ddcutil
        grim
        killall
        playerctl
        slurp
        wl-clipboard
      ];
  };
}
