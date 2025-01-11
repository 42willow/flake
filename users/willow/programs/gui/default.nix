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
          gparted
          keepassxc
          localsend
          polkit_gnome
        ])

        # Fun
        (optionals cfg.categories.fun.enable [
          calibre
          prismlauncher
          vesktop
        ])

        # Privacy
        (optionals cfg.categories.privacy.enable [
          tor-browser
          veracrypt
        ])

        # Multimedia
        (optionals cfg.categories.media.enable [
          darktable
          eog
          vlc
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
          inkscape
          krita

          # 3D design
          blender
          openscad
        ])

        # Education
        (optionals cfg.categories.edu.enable [
          libreoffice
          logseq
          obsidian
          planify
          speedcrunch
        ])
      ];
    # ++ (with inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}; [
    # ghostty # terminal
    # lightburn
    # ]);
  };
}
