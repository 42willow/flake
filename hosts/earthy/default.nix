{
  pkgs,
  inputs,
  config,
  ...
}: let
  inherit (inputs) self;
in {
  imports = [
    ./hardware-configuration.nix
    "${self}/modules"
  ];

  # samba
  environment.systemPackages = [pkgs.cifs-utils];
  fileSystems."/mnt/share" = {
    device = "//192.168.1.30/thinkpad_backup/";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=${config.age.secrets.samba.path}"];
  };
}
