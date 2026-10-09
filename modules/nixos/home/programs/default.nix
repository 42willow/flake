{
  pkgs,
  osConfig,
  lib,
  ...
}: let
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
      (lib.optionals cfg.cli.enable [
        brightnessctl
        ddcutil
        grim
        keepassxc
        killall
        localsend
        nix-output-monitor
        peaclock
        playerctl
        polkit_gnome
        popsicle
        qbittorrent
        slurp
        wl-clipboard
      ])
      ++ (lib.optionals cfg.gui.enable [
        (discord.override {withOpenASAR = true;})
        # blanket
        # darktable
        # drawio
        # ganttproject-bin
        # logseq
        aseprite
        calibre
        eog
        hexchat
        inkscape
        keepassxc
        libreoffice
        localsend
        mpv
        nautilus
        openscad
        polkit_gnome
        popsicle
        prismlauncher
        qalculate-qt
        qbittorrent
        tor-browser
        vesktop
        unstable.obsidian
        unstable.veracrypt
        unstable.cura-appimage
      ]);
  };
}
