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
      "spicetify-cli"
      "syncthing"
      "tldr"
      "typst"
      "yazi"
    ];

    casks = [
      "altserver"
      "angry-ip-scanner"
      "anki"
      "calibre"
      "deskflow"
      "font-atkinson-hyperlegible"
      "font-maple-mono-nf"
      "font-pacifico"
      "ghostty"
      "hot"
      "iina"
      "inkscape"
      "karabiner-elements"
      "keepassxc"
      "keka"
      "lightburn"
      "linearmouse"
      "microsoft-excel"
      "microsoft-word"
      "middleclick"
      "monitorcontrol"
      "notunes"
      "obsidian"
      "openscad@snapshot"
      "prismlauncher"
      "spotify"
      "thunderbird"
      "utm"
      "vesktop"
      "yaak"
      "krita"
    ];
  };
}
