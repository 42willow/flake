{lib, ...}: {
  services.aerospace = {
    enable = false;

    settings = {
      gaps = {
        outer.left = 8;
        outer.bottom = 8;
        outer.top = 8;
        outer.right = 8;
      };
      mode.main.binding =
        {
          # focus
          # https://nikitabobko.github.io/AeroSpace/commands#focus
          alt-n = "focus left";
          alt-e = "focus down";
          alt-i = "focus up";
          alt-o = "focus right";

          alt-s = "fullscreen";

          alt-shift-n = "workspace next";
          alt-shift-o = "workspace prev";
          alt-shift-e = "focus-monitor left";
          alt-shift-i = "focus-monitor right";

          # https://nikitabobko.github.io/AeroSpace/commands#resize
          alt-a = "resize smart -50";
          alt-r = "resize smart +50";

          # https://nikitabobko.github.io/AeroSpace/commands#layout
          alt-slash = "layout tiles horizontal vertical";
          alt-comma = "layout accordion horizontal vertical";

          # https://nikitabobko.github.io/AeroSpace/commands#exec-and-forget
          alt-f = "exec-and-forget open -a Firefox";
          alt-q = "exec-and-forget open -a Ghostty -n";
          alt-t = "exec-and-forget open -a Vesktop";
          alt-w = "exec-and-forget open -a Finder -n";


          # https://nikitabobko.github.io/AeroSpace/commands#workspace-back-and-forth
          alt-tab = "workspace-back-and-forth";
        }
        // lib.foldl' (
          attr: i:
            attr
            // {
              "alt-${toString i}" = "workspace ${toString i}";
              "alt-shift-${toString i}" = "move-node-to-workspace ${toString i} --focus-follows-window";
            }
        ) {} (lib.range 1 9);
    };
  };
}
