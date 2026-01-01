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
    ./atuin.nix
    ./bat.nix
    ./beets.nix
    ./bun.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./ripgrep.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  config = lib.mkIf cfg.cli.enable {
    home.packages = with pkgs;
    with inputs;
      concatLists [
        (optionals cfg.categories.tools.enable [
          catppuccin.packages."${pkgs.system}".catwalk
          catppuccin.packages."${pkgs.system}".whiskers

          # archivebox
          just
          tldr
          typst
        ])
        (optionals cfg.categories.dev.enable [
          # node
          nodePackages.npm
          nodejs
          pnpm

          # nix
          alejandra
          deadnix
          devenv
          direnv
          nix-inspect
          statix

          # rust
          cargo
          gcc # needed for rust-analyzer
          rustc

          # python
          uv
        ])
      ];
  };
}
