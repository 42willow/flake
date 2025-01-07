{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./beets.nix
    ./bun.nix
    ./direnv.nix
    ./eza.nix
    ./fzf.nix
    ./git.nix
    ./nushell.nix
    ./ripgrep.nix
    ./starship.nix
    ./zoxide.nix
    ./zsh.nix
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
