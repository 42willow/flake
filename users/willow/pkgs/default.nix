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
      # catppuccin-whiskers.packages."${pkgs.system}".whiskers
      catppuccin-catwalk.packages."${pkgs.system}".catwalk
      zen-browser.packages."${pkgs.system}".default
    ]
    ++ (with inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; [
      calibre # ebooks
      # ghostty # terminal
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
      darktable
      speedcrunch # calculator
      keepassxc
      gparted
      polkit_gnome
      eog # eye of gnome
      nautilus
      libreoffice
      localsend # local network file sharing
      vlc
      planify
      tor-browser
      # 3D
      blender
      openscad
      # 2D
      inkscape
      krita
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
