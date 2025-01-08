{
  inputs,
  pkgs,
  ...
}: {
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
}
