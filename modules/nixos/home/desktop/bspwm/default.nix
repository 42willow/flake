# Bspwm settings
let
  mod = "super";
  altMod = "alt";
in {
  xsession.windowManager.bspwm = {
    enable = true;
    settings = {};
    extraConfig = ''
      bspc monitor -d Web Music Discord Editor Notes Email 7 8 9 10

      # Mice bindings
      # Set mod key
      bspc config pointer_modifier ${mod}

      #   Set mouse 1 to move floating windows
      bspc config pointer_action1 move

      #   Mouse 2 button resizes the window by side
      bspc config pointer_action2 resize_side

      #   Mouse 3 button (right mouse) resize by corner
      bspc config pointer_action2 resize_corner

      bspc config focus_follows_pointer true
      bspc config automatic_scheme alternate
    '';

    rules = {
      "discord" = {
        desktop = "^3";
        follow = false;
      };
      "Spotify" = {
        desktop = "^2";
        follow = false;
      };
      "apple-music" = {
        desktop = "^2";
        follow = false;
      };
      "obsidian" = {
        desktop = "^5";
        follow = false;
      };
      "thunderbird" = {
        desktop = "^6";
        follow = false;
      };
    };

    startupPrograms = [
      # "${pkgs.polkit_gnome} /libexec/polkit-gnome-authentication-agent-1"
      "thunderbird"
      "obsidian"
      # "xrandr --output HDMI-A-0 --mode 1920x1080 --rate 144 --primary"
    ];
  };

  services.sxhkd = {
    enable = true;

    keybindings = {
      "${mod} + q" = "ghostty";
      "${mod} + c" = "bspc node -c";
      "${mod} + m" = "tofi-drun --drun-launch=true --fuzzy-match=true";
      # "${mod} + r" = "bspc node @focused:/ --rotate 90";
      # "${mod} + shift + r" = "bspc node @focused:/ --rotate 180";
      # "${mod} + y" = "bspc node @parent -R 90";
    };

    extraConfig = ''
      # Switch to different workspaces with back-and-forth support
      ${mod} + {1-9,0}
        desktop='^{1-9,10}'; \
        bspc query -D -d "$desktop.focused" && bspc desktop -f last || bspc desktop -f "$desktop"

      # Move windows to different workspaces
      ${altMod} + {1-9,0}
        bspc node -d ^{1-9,10}

      # Expand/contract a window by moving one of its side outward/inward
      ${mod} + s : {h,j,k,l}
          STEP=30; SELECTION={1,2,3,4}; \
          bspc node -z $(echo "left -$STEP 0,bottom 0 $STEP,top 0 -$STEP,right $STEP 0" | cut -d',' -f$SELECTION) || \
          bspc node -z $(echo "right -$STEP 0,top 0 $STEP,bottom 0 -$STEP,left $STEP 0" | cut -d',' -f$SELECTION)

      ${mod} + {t,shift + t,f,shift + f}
          bspc node -t '~{tiled,pseudo_tiled,floating,fullscreen}'

      # focus the node in the given direction
      ${mod} + {_,shift + }{h,j,k,l}
          bspc node -{f,s} {west,south,north,east}
    '';
  };
}
