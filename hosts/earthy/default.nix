{
  self,
  pkgs,
  lib,
  config,
  ...
}: let
  inherit (self.lib) mkSecret;
  inherit (config.sops) secrets;
in {
  imports = [
    ./disko.nix
    ./hardware-configuration.nix
    ./preservation.nix
    ./users.nix
    "${self}/modules/nixos"
  ];

  nest = {
    hostName = "earthy";
    profiles = {
      graphical.enable = true;
      dev.enable = true;
    };
    hardware = {
      printing.enable = true;
      sound.enable = true;
    };
    services = {
      actual.enable = true;
      calibre-server.enable = true;
      dispatcharr.enable = true;
      freshrss.enable = true;
      gatus.enable = true;
      gonic.enable = true;
      immich.enable = true;
      jellyfin.enable = true;
      koito.enable = false;
      mpdscribble.enable = false;
      radicale.enable = true;
      restic.enable = true;
      tailscale.enable = true;
      uhf-server.enable = true;
    };
  };

  programs = {
    # build first with niri disabled, then enable after cache is added
    niri.enable = true;
    steam.enable = true; # no config
    zsh.enable = true; # no config
  };

  sops = {
    secrets = {
      healthchecks-earthy-ping-key = mkSecret {
        file = "healthchecks";
        key = "earthy/ping-key";
        mode = "0444"; # world readable
      };
      samba-nas-username = mkSecret {
        file = "samba-nas";
        key = "username";
      };
      samba-nas-password = mkSecret {
        file = "samba-nas";
        key = "password";
      };
    };
    templates.samba-nas-env.content = with config.sops.placeholder; ''
      username=${samba-nas-username}
      password=${samba-nas-password}
    '';
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
      "credentials=${config.sops.templates.samba-nas-env.path}"
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

  systemd = {
    # healthchecks.io deadman's switch
    timers.earthy-heartbeat = {
      description = "trigger earthy heartbeat service once hourly";
      timerConfig = {
        OnBootSec = "2min";
        OnCalendar = "hourly";
        Persistent = true;
      };
      wantedBy = ["timers.target"];
    };

    services.earthy-heartbeat = {
      description = "ping healthchecks.io deadman's switch";
      wants = ["network-online.target"];
      after = ["network-online.target"];
      unitConfig.ConditionPathExists = secrets.healthchecks-earthy-ping-key.path;
      script = ''
        key="$(${lib.getExe' pkgs.coreutils "cat"} ${secrets.healthchecks-earthy-ping-key.path})"
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
      serviceConfig = {
        Type = "oneshot";
        DynamicUser = true;
      };
    };

    targets = {
      sleep.enable = false;
      suspend.enable = false;
      hibernate.enable = false;
      hybrid-sleep.enable = false;
    };
  };

  services.logind.settings.Login = {
    HandleLidSwitch = "ignore";
    HandleLidSwitchExternalPower = "ignore";
    HandleLidSwitchDocked = "ignore";
  };
}
