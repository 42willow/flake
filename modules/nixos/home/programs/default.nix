{
  inputs,
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) optionals concatLists;
  cfg = osConfig.settings.programs;
in {
  imports = [
    ./chromium.nix
    ./firefox
    ./hyfetch.nix
    ./ncmpcpp.nix
    ./nushell.nix
    ./quickshell.nix
    ./spicetify.nix
    ./thunderbird.nix
    ./tofi.nix
    ./waybar
    ./yazi.nix
    ./zed
    # ./cura.nix
    # ./floorp.nix
    # ./lazygit.nix
    # ./lightburn.nix
    # ./obs-studio.nix
  ];
  config = {
    home.packages = with pkgs;
    with inputs;
      concatLists lib.mkIf cfg.cli.enable [
        (optionals cfg.categories.tools.enable [
          brightnessctl
          ddcutil
          grim
          killall
          playerctl
          slurp
          wl-clipboard
          keepassxc
          localsend
          polkit_gnome
          popsicle
          qbittorrent
        ])

        (optionals cfg.categories.dev.enable [
          # nix
          nix-output-monitor
        ])
      ]
      ++ concatLists lib.mkIf cfg.gui.enable
      [
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
          # darktable
          eog
          mpv
        ])

        (optionals cfg.categories.fs.enable [
          nautilus
        ])

        # (optionals cfg.categories.dev.enable [
        #   vscode
        # ])

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
      ++ lib.mkIf cfg.gui.enable (with pkgs.unstable;
        concatLists [
          (optionals cfg.categories.tools.enable [
            obsidian
            veracrypt
          ])

          (optionals cfg.categories.design.enable [
            cura-appimage
          ])
        ])
      ++ lib.mkIf cfg.tui.enable {
        home.packages = with pkgs;
          concatLists [
            (optionals cfg.categories.tools.enable [
              peaclock
            ])
          ];
      };
  };
}
