{pkgs, ...}: {
  imports = [
    ./browsers
    ./waybar
    ./cura.nix
    ./kitty.nix
    ./obs-studio.nix
    ./spicetify.nix
    ./thunderbird.nix
    ./tofi.nix
    ./zed.nix
  ];

  home.packages = with pkgs; [
    # Utils
    keepassxc
    localsend
    gparted
    polkit_gnome

    # Recreation
    vesktop
    prismlauncher
    calibre

    # Privacy
    tor-browser
    veracrypt

    # Multimedia
    vlc
    eog
    nautilus
    darktable

    # Programming
    kitty
    vscode

    # Graphic design
    aseprite
    krita
    inkscape

    # 3D design
    blender
    openscad

    # Education
    obsidian
    logseq
    speedcrunch
    libreoffice
    planify
  ];
  # ++ (with inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; [
  #     # ghostty # terminal
  #   ]);
}
