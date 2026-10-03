{
  self,
  pkgs,
  lib,
  config,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    "${self}/modules/nixos"
  ];

  settings = {
    system = {
      hostName = "earthy";
      services = {
        backups.enable = true; # restic
        sync = with config.age; {
          enable = true;
          key = secrets.syncthingEarthyKey.path;
          cert = secrets.syncthingEarthyCert.path;
        };
      };
    };
  };

  # samba
  environment.systemPackages = [pkgs.cifs-utils];
  fileSystems."/mnt/nas" = {
    device = "//192.168.1.30/thinkpad_backup";
    fsType = "cifs";
    options = [
      "x-systemd.automount"
      "noauto"
      "x-systemd.idle-timeout=60"
      "x-systemd.device-timeout=5s"
      "x-systemd.mount-timeout=5s"
      "x-systemd.requires=network-online.target"
      "credentials=${config.age.secrets.sambaNas.path}"
    ];
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PermitRootLogin = "yes";
      };
    };
    udisks2.enable = true;
    gvfs.enable = true;
    samba = {
      enable = true;
      package = pkgs.samba4Full; # mDNS and LDAP capability
      openFirewall = true;

      settings = {
        global = {
          "workgroup" = "WORKGROUP";
          "server string" = "earthy fileserver";
          "netbios name" = "earthy";
          "security" = "user";

          "mdns name" = "mdns"; # local system's lowercase hostname over mDNS

          # macos finder view
          "vfs objects" = "fruit streams_xattr";
          "fruit:aapl" = "yes";
          "fruit:model" = "MacBookPro";
          "fruit:metadata" = "stream";
          "fruit:posix_rename" = "yes";
          "fruit:veto_appledouble" = "no";
        };

        "homes" = {
          "comment" = "Home Directories";
          "browseable" = "no";
          "read only" = "no";
          "guest ok" = "no";
          "valid users" = "%S";
          "create mask" = "0600";
          "directory mask" = "0700";
        };

        "shared-ntfs" = {
          "comment" = "Shared NTFS";
          "path" = "/mnt/shared";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "valid users" = "willow";
          "force user" = "willow";
        };
      };
    };

    avahi = {
      enable = true;
      nssmdns4 = true;
      openFirewall = true;
      publish = {
        enable = true;
        domain = true; # broadcast mdns
        addresses = true; # broadcast mdns
        userServices = true; # i.e. samba
      };
    };

    tailscale = {
      enable = true;
      package = pkgs.unstable.tailscale;
      openFirewall = true;
      extraSetFlags = [
        "--advertise-exit-node"
        "--advertise-routes=10.10.1.0/24"
      ];
      useRoutingFeatures = "both";
    };

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

  # disable firewall for tailscale
  networking.firewall.trustedInterfaces = [config.services.tailscale.interfaceName];

  # required for ZFS
  networking.hostId = "c49b1e3e";

  # healthchecks.io deadman's switch
  systemd.timers.earthy-heartbeat = {
    description = "trigger earthy heartbeat service once hourly";
    timerConfig = {
      OnBootSec = "2min";
      OnCalendar = "hourly";
      Persistent = true;
    };
    wantedBy = ["timers.target"];
  };

  systemd.services.earthy-heartbeat = let
    inherit (config.age.secrets) healthchecksPingKey;
  in {
    description = "ping healthchecks.io deadman's switch";
    wants = ["network-online.target"];
    after = ["network-online.target"];
    unitConfig.ConditionPathExists = healthchecksPingKey.path;
    script = ''
      key="$(${lib.getExe' pkgs.coreutils "cat"} ${healthchecksPingKey.path})"
      url="https://hc-ping.com/''${key}/earthy-heartbeat"
      ${pkgs.curl}/bin/curl \
        --fail \
        --silent \
        --show-error \
        --max-time 10 \
        --retry 5 \
        --output /dev/null \
        "$url"
    '';
    serviceConfig.Type = "oneshot";
  };

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
