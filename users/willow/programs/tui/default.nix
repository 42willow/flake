{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs.tui;
in {
  imports = [
    # ./nvim
    ./bat.nix # core
    ./btop.nix # core
    ./gitui.nix # dev
    ./ncmpcpp.nix # music
    ./yazi.nix # files
  ];

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      peaclock
    ];
  };
}
