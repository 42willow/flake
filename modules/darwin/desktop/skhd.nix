{
  services.skhd = {
    enable = true;

    skhdConfig = ''
      alt - escape : yabai -m space --toggle mission-control

      alt - n : yabai -m window --focus west
      alt - e : yabai -m window --focus south
      alt - i : yabai -m window --focus north
      alt - o : yabai -m window --focus east

      alt + shift - n : yabai -m space --focus prev
      alt + shift - o : yabai -m space --focus next

      alt - q : id=$(yabai -m query --windows | jq -re ".[] | select(.app == \"Ghostty\") | .id" | head -n 1) && [ -z "$id" ] && open -a Ghostty || (yabai -m window --focus $id && skhd -k "cmd - n")

      ${builtins.concatStringsSep "\n" (
        builtins.genList (
          i: "alt - ${toString (i + 1)} : yabai -m space --focus ${toString (i + 1)}"
        )
        9
      )}
    '';
  };
}
