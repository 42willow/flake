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
    ./browsers
    ./waybar # core
    # ./cura.nix # 3dp
    # ./lightburn.nix # cnc
    # ./obs-studio.nix # media
    ./quickshell.nix # core
    ./spicetify.nix # music
    ./thunderbird.nix # mail
    ./tofi.nix # core
    ./zed # dev
    ./zathura.nix # media
  ];

  config = lib.mkIf cfg.gui.enable {
    home.packages = with pkgs;
      concatLists [
        (optionals cfg.categories.tools.enable [
          keepassxc
          localsend
          polkit_gnome
          popsicle
          qbittorrent
        ])

        (optionals cfg.categories.fun.enable [
          calibre
          prismlauncher
          vesktop
          hexchat
          (discord.override {
            withOpenASAR = true;
          })
        ])

        (optionals cfg.categories.privacy.enable [
          tor-browser
        ])

        (optionals cfg.categories.media.enable [
          darktable
          eog
          mpv
        ])

        (optionals cfg.categories.fs.enable [
          nautilus
        ])

        (optionals cfg.categories.dev.enable [
          vscode
        ])

        (optionals cfg.categories.design.enable [
          # graphic design
          aseprite
          inkscape

          # 3D design
          # blender
          openscad
        ])

        (optionals cfg.categories.edu.enable [
          # drawio
          # ganttproject-bin
          libreoffice
          # logseq
          qalculate-qt
          # blanket
        ])
      ]
      ++ (with pkgs.unstable;
        concatLists [
          (optionals cfg.categories.tools.enable [
            obsidian
            veracrypt
          ])

          (optionals cfg.categories.design.enable [
            cura-appimage
          ])
        ]);
  };
}
