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
    ];

    brews = [
      # these will gradually be replaced with nixpkgs
      "gh"
      "just"
      "libqalculate"
      "ncmpcpp"
      "spicetify-cli"
      "yazi"
    ];

    casks = [
      "affinity"
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
      "krita"
      "lightburn"
      "linearmouse"
      "microsoft-excel"
      "microsoft-word"
      "middleclick"
      "monitorcontrol"
      "notunes"
      "obsidian"
      "openscad@snapshot"
      "orcaslicer"
      "prismlauncher"
      "spotify"
      "thunderbird"
      "utm"
      "vesktop"
      "yaak"
    ];
  };
}
