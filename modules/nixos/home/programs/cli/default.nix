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
    ./hyfetch.nix # tools
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
          catppuccin.packages."${pkgs.system}".catwalk
          catppuccin.packages."${pkgs.system}".whiskers

          # Utils
          archivebox
          brightnessctl
          ddcutil
          grim
          just
          killall
          playerctl
          slurp
          tldr
          typst
          wl-clipboard
        ])

        (optionals cfg.categories.dev.enable [
          # Node
          nodePackages.npm
          nodejs
          pnpm

          # Nix
          alejandra
          deadnix
          devenv
          direnv
          nix-inspect
          nix-output-monitor
          statix

          # Rust
          cargo
          gcc # needed for rust-analyzer
          rustc
        ])
      ];
  };
}
