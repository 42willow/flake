{
  lib,
  pkgs,
  config,
  ...
}: let
  cfg = config.settings.services;
in {
  imports = [
    ./pipewire.nix
    ./printing.nix
    ./privacy.nix
    ./restic.nix
    # ./sddm.nix
    ./tlp.nix
    # ./xfce.nix
  ];

  options.settings.services = {
    enable =
      lib.mkEnableOption "System services"
      // {
        default = true;
      };
  };
  config = lib.mkIf cfg.enable {
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

      udev.packages = [
        pkgs.platformio-core
        pkgs.openocd
      ];
    };
  };
}
