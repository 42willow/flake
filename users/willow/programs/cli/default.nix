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
    ./beets.nix # music
    ./bun.nix # dev
    ./direnv.nix # dev
    ./eza.nix # core
    ./fzf.nix # tools
    ./git.nix # core
    ./nushell.nix # core
    ./ripgrep.nix # tools
    ./starship.nix # core
    ./zoxide.nix # core
    ./zsh.nix # core
  ];
  config = lib.mkIf cfg.cli.enable {
    home.packages = with pkgs;
    with inputs;
      concatLists [
        (optionals cfg.categories.tools.enable [
          catppuccin-whiskers.packages."${pkgs.system}".whiskers
          catppuccin-catwalk.packages."${pkgs.system}".catwalk

          # Utils
          tldr
          fastfetch
          just
          killall
          playerctl
          grim
          slurp
          wl-clipboard
          ddcutil
          brightnessctl
        ])

        (optionals cfg.categories.dev.enable [
          # Node
          nodejs
          nodePackages.npm
          pnpm

          # Nix
          alejandra
          statix
          deadnix
          devenv
          direnv

          # Rust
          cargo
          rustc
          gcc # needed for rust-analyzer
        ])
      ];
  };
}
