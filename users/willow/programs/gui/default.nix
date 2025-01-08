{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs.gui;
in {
  imports = [
    ./browsers # browsers
    ./waybar # core
    ./cura.nix # 3dp
    ./kitty.nix # core
    ./obs-studio.nix # media
    ./spicetify.nix # music
    ./thunderbird.nix # mail
    ./tofi.nix # core
    ./zed.nix # dev
  ];

  config = lib.mkIf cfg.enable {
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
  };
}
