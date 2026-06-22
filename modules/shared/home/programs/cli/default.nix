{
  lib,
  inputs,
  pkgs,
  osConfig,
  ...
}: let
  inherit (lib) optionals concatLists;
  cfg = osConfig.nest.programs;
in {
  imports = [
    ./atuin.nix
    ./bat.nix
    ./beets.nix
    ./btop.nix
    ./bun.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./gitui.nix
    ./helix
    ./ripgrep.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
  ];

  config = lib.mkIf cfg.cli {
    home.packages = with pkgs;
    with inputs;
      concatLists [
        [
          catppuccin.packages."${pkgs.stdenv.hostPlatform.system}".catwalk
          catppuccin.packages."${pkgs.stdenv.hostPlatform.system}".whiskers

          just
          tldr
          typst
        ]
        (optionals cfg.devtools.enable [
          # TODO use categories
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

          # zig
          zig

          # haskell
          ghc

          # python
          uv
        ])
      ];
  };
}
