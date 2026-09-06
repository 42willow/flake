{
  self,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    "${self}/modules/nixos"
  ];

  settings = {
    system = {
      hostName = "earthy";
      services.sync.enable = true;
    };
  };

  # samba
  environment.systemPackages = [pkgs.cifs-utils];
  # fileSystems."/mnt/nas" = {
  #   device = "//192.168.1.30/thinkpad_backup/";
  #   fsType = "cifs";
  #   options = let
  #     # this line prevents hanging on network split
  #     automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #   in ["${automount_opts},credentials=${config.age.secrets.samba.path}"];
  # };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        addresses = true; # broadcast mdns
        workstation = false; # visiblity in file managers
      };
    };

    tailscale.enable = true;

    tlp = {
      enable = true;
      settings = {
        START_CHARGE_THRESH_BAT0 = 40;
        STOP_CHARGE_THRESH_BAT0 = 50;
        CPU_ENERGY_PERF_POLICY_ON_AC = "balance_power";
        CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
        PLATFORM_PROFILE_ON_AC = "balanced";
        PLATFORM_PROFILE_ON_BAT = "balanced";
        RUNTIME_PM_ON_AC = "auto"; # enable runtime power management
        RUNTIME_PM_ON_BAT = "auto";
        WIFI_PWR_ON_AC = "off"; # disable wifi power save
        WIFI_PWR_ON_BAT = "off";
        CPU_SCALING_MAX_FREQ_ON_AC = 1600000;
        CPU_SCALING_MAX_FREQ_ON_BAT = 1600000;
      };
    };

    fwupd.enable = true;
  };

  # required for ZFS
  networking.hostId = "c49b1e3e";

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
  systemd.targets = {
    sleep.enable = false;
    suspend.enable = false;
    hibernate.enable = false;
    hybrid-sleep.enable = false;
  };
}
