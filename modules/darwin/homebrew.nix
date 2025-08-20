{
  homebrew = {
    enable = true;
    # onActivation = {
    #   autoUpdate = true;
    #   cleanup = "uninstall";
    #   upgrade = true;
    # };

    taps = [
      "deskflow/tap"
      "felixkratz/formulae"
      "jackielii/tap"
      "koekeishiya/formulae"
      "oven-sh/bun"
    ];

    brews = [
      # these will gradually be replaced with nixpkgs
      "bat"
      "bun"
      "gh"
      "gitui"
      "just"
      "libqalculate"
      "mpd"
      "ncmpcpp"
      "pnpm"
      "sketchybar" # TODO)) remove
      "spicetify-cli"
      "starship"
      "syncthing"
      "typst"
      "yazi"
      "zoxide"
    ];

    casks = [
      "alacritty"
      "angry-ip-scanner"
      "anki"
      "calibre"
      "deskflow"
      "font-atkinson-hyperlegible"
      "font-maple-mono-nf"
      "font-pacifico"
      "ghostty"
      "iina"
      "inkscape"
      "karabiner-elements"
      "keepassxc"
      "keka"
      "microsoft-excel"
      "microsoft-word"
      "middleclick"
      "monitorcontrol"
      "obsidian"
      "prismlauncher"
      "scroll-reverser"
      "spotify"
      "thunderbird"
      "vesktop"
    ];
  };
}
