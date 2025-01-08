{
  inputs,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs.cli;
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
  config = lib.mkIf cfg.enable {
    home.packages = with pkgs;
      [
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
      ]
      ++ (with inputs; [
        catppuccin-whiskers.packages."${pkgs.system}".whiskers
        catppuccin-catwalk.packages."${pkgs.system}".catwalk
      ]);
  };
}
