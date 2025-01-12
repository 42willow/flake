{pkgs, ...}: let
  startupScript = pkgs.pkgs.writeShellScriptBin "start" ''
    ${pkgs.waybar}/bin/waybar &
    ${pkgs.hyprpaper}/bin/hyprpaper &
    ${pkgs.hypridle}/bin/hypridle &
    ${pkgs.wl-clipboard}/bin/wl-paste --type text --watch cliphist store &
    ${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1 &
    ${pkgs.networkmanagerapplet}/bin/nm-applet &
    dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP &
  '';
in {
  wayland.windowManager.hyprland.settings = {
    exec-once = ''${startupScript}/bin/start'';
  };
}
