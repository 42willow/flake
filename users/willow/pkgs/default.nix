{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    ./cli
    ./gui
    ./tui
  ];

  home.packages = with inputs;
    [
      # TODO: whiskers
      # catppuccin-whiskers.packages.${pkgs.system}.whiskers
      catppuccin-catwalk.packages.${pkgs.system}.catwalk
      inputs.zen-browser.packages."${pkgs.system}".default
    ]
    ++ (with inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; [
      calibre # ebooks
    ])
    ++ (with pkgs; [
      hypridle
      hyprpicker
      hyprcursor
      # Programming
      kitty
      vscode
      # Procrastination
      prismlauncher
      vesktop
      aseprite
      # Work
      obsidian
      logseq
      # CLI
      tldr
      fastfetch
      just
      killall
      playerctl
      # TUI
      peaclock
      # GUI
      speedcrunch # calculator
      keepassxc
      gparted
      polkit_gnome
      eog # eye of gnome
      nautilus
      libreoffice
      localsend # local network file sharing
      vlc
      # Nix Formatter
      alejandra
      statix
      deadnix
      # Screen
      grim
      slurp
      wl-clipboard
      ddcutil
      brightnessctl
      # Build tools
      nodejs
      nodePackages.npm
      pnpm
      devenv
      mdbook
      cargo
      rustc
      gcc # needed for rust-analyzer
      direnv
    ]);
}
