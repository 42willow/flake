{
  self,
  pkgs,
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
  #   in ["${automount_opts},credentials=${config.age.secrets.sambaNas.path}"];
  # };

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

          "mdns name" = "mdns"; # Forces Samba to respect the local system's lowercase hostname over mDNS

          # macOS Finder Optimisations
          "vfs objects" = "fruit streams_xattr";
          "fruit:aapl" = "yes";
          "fruit:model" = "MacBookPro";
          "fruit:metadata" = "stream";
          "fruit:posix_rename" = "yes";
          "fruit:veto_appledouble" = "no";
        };

        "homes" = {
          "comment" = "Home Directories";
          "browseable" = "no"; # Keeps other users' home folders hidden
          "read only" = "no"; # Allows you to write/save files
          "guest ok" = "no"; # Requires your password to access
          "valid users" = "%S"; # Crucial security: only allows the owner to log into their own home
          "create mask" = "0600"; # Ensures new files are only readable by you
          "directory mask" = "0700"; # Ensures new folders are only accessible by you
        };

        "shared-ntfs" = {
          "comment" = "Shared NTFS";
          "path" = "/mnt/shared";
          "browseable" = "yes";
          "read only" = "no";
          "guest ok" = "no";
          "valid users" = "willow"; # Limits access exclusively to user "willow"
          "force user" = "willow"; # Forces Samba to write as UID 1000 matching the mount options
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
      # serve = {
      #   enable = true;
      #   services = {
      #     navidrome = let
      #       port = config.services.navidrome.settings.Port;
      #     in {
      #       endpoints."tcp:443" = "http://localhost:${port}";
      #     };
      #     koito = let
      #       port = config.services.koito.environment.KOITO_LISTEN_PORT;
      #     in {
      #       endpoints."tcp:443" = "http://localhost:${port}";
      #     };
      #   };
      # };
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
