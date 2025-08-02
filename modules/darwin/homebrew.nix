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
      "helix"
      "just"
      "libqalculate"
      "mpd"
      "ncmpcpp"
      "pnpm"
      "sketchybar" # TODO)) remove
      "skhd" # TODO)) replace
      "spicetify-cli"
      "starship"
      "syncthing"
      "typst"
      "yabai"
      "yazi"
      "zoxide"
    ];

    casks = [
      "alacritty"
      "deskflow"
      "font-atkinson-hyperlegible"
      "font-maple-mono-nf"
      "font-pacifico"
      "ganttproject"
      "ghostty"
      "iina"
      "karabiner-elements"
      "keepassxc"
      "keka"
      "microsoft-auto-update"
      "microsoft-excel"
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
