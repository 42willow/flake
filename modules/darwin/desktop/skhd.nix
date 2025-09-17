{
  services.skhd = {
    enable = false;

    skhdConfig = ''
      alt - escape : yabai -m space --toggle mission-control

      alt - n : yabai -m window --focus west
      alt - e : yabai -m window --focus south
      alt - i : yabai -m window --focus north
      alt - o : yabai -m window --focus east

      alt + shift - n : yabai -m space --focus prev
      alt + shift - e : yabai -m display --focus next
      alt + shift - i : yabai -m display --focus prev
      alt + shift - o : yabai -m space --focus next

      alt - q : open -a Ghostty -n

      ${builtins.concatStringsSep "\n" (
        builtins.genList (
          i: "alt - ${toString (i + 1)} : yabai -m space --focus ${toString (i + 1)}"
        )
        9
      )}
    '';
  };
}
