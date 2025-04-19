{
  pkgs,
  osConfig,
  lib,
  inputs,
  ...
}: let
  inherit (lib) optionals concatLists;
  cfg = osConfig.settings.programs;
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  imports = [
    ./browsers # browsers
    ./waybar # core
    # ./cura.nix # 3dp
    ./ghostty.nix # core
    ./kitty.nix # core
    ./lightburn.nix # cnc
    ./obs-studio.nix # media
    ./spicetify.nix # music
    ./thunderbird.nix # mail
    ./tofi.nix # core
    ./zed # dev
  ];

  config = lib.mkIf cfg.gui.enable {
    home.packages = with pkgs;
      concatLists [
        # Core
        # (optionals cfg.categories.core.enable [
        #   kitty
        # ])

        # Tools
        (optionals cfg.categories.tools.enable [
          keepassxc
          localsend
          polkit_gnome
          qbittorrent
        ])

        # Fun
        (optionals cfg.categories.fun.enable [
          calibre
          prismlauncher
          vesktop
          (discord.override {
            withOpenASAR = true;
          })
        ])

        # Privacy
        (optionals cfg.categories.privacy.enable [
          tor-browser
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
          planify
          speedcrunch
        ])
      ]
      ++ (with pkgs-unstable; [
        veracrypt
        obsidian
      ]);
  };
}
