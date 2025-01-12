# Credits to:
# - https://github.com/Nitestack/dotfiles/blob/master/nix/home-manager/hyprland/plugins/hyprlock.nix
# - https://github.com/BHlmaoMSD/dotfiles/blob/main/hypr/hyprlock.conf
{
  inputs,
  pkgs,
  ...
}: let
  scripts = {
    song-art = pkgs.writeShellScriptBin "song-art" ''
      #!/usr/bin/env bash

      file_dir=$(playerctl metadata --format '{{mpris:artUrl}}' | sed 's/file:\/\///')

      if [[ $(playerctl status) == "Playing" ]]; then
        echo $file_dir
      fi
    '';
    song-info = pkgs.writeShellScriptBin "song-info" ''
      #!/usr/bin/env bash

      artist=$(playerctl metadata --format '{{artist}}')
      title=$(playerctl metadata --format '{{title}}')

      if [[ $(playerctl status) == "Playing" ]]; then
        case "$1" in
        --title)
          echo $title
          ;;
        --artist)
          echo $artist
          ;;
        esac
      fi
    '';
  };
in {
  programs.hyprlock = {
    enable = true;
    # package = inputs.nixpkgs-unstable.legacyPackages.${pkgs.system}.hyprlock;
    # See https://wiki.hyprland.org/Hypr-Ecosystem/hyprlock
    settings = {
      general = {
        disable_loading_bar = true;
        hide_cursor = true;
      };

      # ── Background ────────────────────────────────────────────────────────
      background = {
        path = "${inputs.wallpapers}/dist/Macchiato/Kurzgesagt-Unknown_Lifeform.png";
        blur_passes = 2;
      };

      # ── Labels ────────────────────────────────────────────────────────────
      label = [
        {
          monitor = "";
          text = "cmd[update:1000] echo \"$(date +\"%A, %d. %B\")\"";
          color = "$text";
          font_size = 20;
          position = "0, 400";
          halign = "center";
          valign = "center";
        }
        {
          monitor = "";
          text = "cmd[update:1000] echo \"\$(date +\"%-H:%M\")\"";
          color = "$text";
          font_size = 93;
          position = "0, 253";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo \"$(${scripts.song-info}/bin/song-info --title)\"";
          color = "$text";
          font_size = 17;
          position = "0, -270";
          halign = "center";
          valign = "center";
        }
        {
          text = "cmd[update:1000] echo \"$(${scripts.song-info}/bin/song-info --artist)\"";
          color = "$text";
          font_size = 15;
          position = "0, -300";
          halign = "center";
          valign = "center";
        }
      ];

      # ── Input Field ───────────────────────────────────────────────────────
      input-field = {
        size = "300, 60";
        outline_thickness = 4;
        dots_size = 0.2;
        dots_spacing = 0.2;
        dots_center = true;
        outer_color = "$accent";
        inner_color = "$surface0";
        font_color = "$text";
        fade_on_empty = false;
        placeholder_text = "<span foreground=\"##$textAlpha\">󰌾 Password...</span>";
        hide_input = false;
        check_color = "$accent";
        fail_color = "$red";
        position = "0, 65";
        halign = "center";
        valign = "bottom";
      };

      # ── Images ────────────────────────────────────────────────────────────
      image = [
        {
          size = 256;
          rounding = 6;
          border_size = 3;
          border_color = "$accent";
          rotate = -6;
          reload_time = 2;
          reload_cmd = "${scripts.song-art}/bin/song-art";
          position = "0, -25";
          halign = "center";
          valign = "center";
        }
        {
          size = 256;
          rounding = 6;
          border_size = 4;
          border_color = "$accent";
          rotate = 0;
          reload_time = 2;
          reload_cmd = "${scripts.song-art}/bin/song-art";
          position = "0, -25";
          halign = "center";
          valign = "center";
        }
      ];
    };
  };
}
