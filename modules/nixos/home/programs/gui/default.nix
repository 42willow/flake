{
  pkgs,
  osConfig,
  lib,
  ...
}: let
  inherit (lib) optionals concatLists;
  cfg = osConfig.nest.programs;
in {
  imports = [
    ./browsers
    ./waybar
    # ./lightburn.nix
    # ./obs-studio.nix
    ./quickshell.nix
    ./spicetify.nix
    ./thunderbird.nix
    ./tofi.nix
    ./zed
  ];

  config = lib.mkIf cfg.gui {
    home.packages = with pkgs;
      concatLists [
        [
          keepassxc
          localsend
          polkit_gnome
          popsicle
          nautilus
        ]

        (optionals cfg.games.enable [
          prismlauncher
        ])

        (optionals cfg.privacy.enable [
          tor-browser
        ])

        (optionals cfg.media.enable [
          # darktable
          eog
          mpv
          calibre
          qbittorrent
        ])

        (optionals cfg.social.enable [
          vesktop
          hexchat
          (discord.override {
            withOpenASAR = true;
          })
        ])

        (optionals cfg.design.enable [
          aseprite
          inkscape
          openscad
        ])

        (optionals cfg.productivity.enable [
          libreoffice
          qalculate-qt
        ])
      ]
      ++ (with pkgs.unstable;
        concatLists [
          (optionals cfg.privacy.enable [
            veracrypt
          ])

          (optionals cfg.productivity.enable [
            obsidian
          ])

          (optionals cfg.media.enable [
            cura-appimage
          ])
        ]);
  };
}
