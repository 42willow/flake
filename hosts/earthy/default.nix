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

  settings.system.hostName = "earthy";

  # samba
  environment.systemPackages = [pkgs.cifs-utils];
  fileSystems."/mnt/nas" = {
    device = "//192.168.1.30/thinkpad_backup/";
    fsType = "cifs";
    options = let
      # this line prevents hanging on network split
      automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
    in ["${automount_opts},credentials=${config.age.secrets.samba.path}"];
  };

  # tlp
  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
      WIFI_PWR_ON_AC = "off"; # default: off
      WIFI_PWR_ON_BAT = "off"; # default: on  todo)) trying to resolve samba frozen unit session slice issue
    };
  };

  # fwupd
  services.fwupd = {
    enable = true;
  };
}
