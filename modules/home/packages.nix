{
  pkgs,
  inputs,
  osConfig,
  lib,
  ...
}: let
  inherit (pkgs.stdenv.hostPlatform) isLinux;
  inherit (lib) optionals concatLists;
  inherit (osConfig) nest;
in {
  home.packages = with pkgs;
  with inputs;
    concatLists [
      # Shared - GUI
      (optionals nest.profiles.graphical.enable [
        chiri
      ])

      # Shared - CLI (tools)
      [
        tldr
      ]

      # Shared - CLI (dev)
      (optionals nest.profiles.dev.enable [
        alejandra
        cargo
        catppuccin.packages."${pkgs.stdenv.hostPlatform.system}".catwalk
        catppuccin.packages."${pkgs.stdenv.hostPlatform.system}".whiskers
        deadnix
        devenv
        direnv
        gcc # needed for rust-analyzer
        ghc # haskell
        just
        nix-inspect
        rustc
        statix
        typst
        uv
        zig
        # pnpm
      ])

      # NixOS - CLI
      (optionals isLinux [
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

      # NixOS - GUI
      (optionals (nest.profiles.graphical.enable && isLinux) [
        (discord.override {withOpenASAR = true;})
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
        # blanket
        # darktable
        # drawio
        # ganttproject-bin
        # logseq
      ])
    ];
}
