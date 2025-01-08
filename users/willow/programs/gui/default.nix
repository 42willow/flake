{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) optionals concatLists;
  cfg = osConfig.settings.programs;
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

  config = lib.mkIf cfg.gui.enable {
    home.packages = with pkgs;
      concatLists [
        # Core
        (optionals cfg.categories.core.enable [
          kitty
        ])

        # Tools
        (optionals cfg.categories.tools.enable [
          keepassxc
          localsend
          gparted
          polkit_gnome
        ])

        # Fun
        (optionals cfg.categories.fun.enable [
          vesktop
          prismlauncher
          calibre
        ])

        # Privacy
        (optionals cfg.categories.privacy.enable [
          tor-browser
          veracrypt
        ])

        # Multimedia
        (optionals cfg.categories.media.enable [
          vlc
          eog
          darktable
        ])

        # Filesystem
        (optionals cfg.categories.fs.enable [
          nautilus
        ])

        # Development
        (optionals cfg.categories.dev.enable [
          vscode
        ])

        # Design
        (optionals cfg.categories.design.enable [
          # Graphic design
          aseprite
          krita
          inkscape

          # 3D design
          blender
          openscad
        ])

        # Education
        (optionals cfg.categories.edu.enable [
          obsidian
          logseq
          speedcrunch
          libreoffice
          planify
        ])
      ];
    # ++ (with inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; [
    #     # ghostty # terminal
    #   ]);
  };
}
