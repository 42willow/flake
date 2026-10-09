{
  services = {
    gnome.gnome-keyring.enable = true;
    dbus.enable = true; # D-Bus message bus
    fstrim.enable = true; # SSD TRIM
    gvfs.enable = true; # GNOME Virtual File System

    xserver.xkb = {
      layout = "us,us";
      variant = "colemak,";
      options = "grp:alt_space_toggle, caps:backspace, shift:both_capslock_cancel";
    };
  };
}
