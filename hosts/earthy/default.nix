{
  inputs,
  pkgs,
  ...
}: {
  imports = [
    ./hardware-configuration.nix
    ./../../modules
    ./../../users
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "electron-27.3.11"
  ];

  fileSystems."/run/media/arch" = {
    device = "/dev/disk/by-uuid/17a0b73e-30de-424f-9f3c-44294696695a";
    fsType = "btrfs";
  };

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
    ];
  };

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  boot.loader = {
    systemd-boot = {
      enable = true;
      editor = false;
      memtest86.enable = true;
      netbootxyz.enable = true;
    };
    efi.canTouchEfiVariables = true;
  };

  hardware.i2c.enable = true; # needed for ddcutil

  services.tlp = {
    enable = true;
    settings = {
      CPU_ENERGY_PERF_POLICY_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "balance_power";
      PLATFORM_PROFILE_ON_AC = "performance";
      PLATFORM_PROFILE_ON_BAT = "low-power";
    };
  };

  # Samba NAS
  environment.systemPackages = [pkgs.cifs-utils];
  # fileSystems."/mnt/share" = {
  #   device = "//192.168.1.30/thinkpad_backup/";
  #   fsType = "cifs";
  #   options = let
  #     # this line prevents hanging on network split
  #     automount_opts = "x-systemd.automount,noauto,x-systemd.idle-timeout=60,x-systemd.device-timeout=5s,x-systemd.mount-timeout=5s";
  #   in ["${automount_opts},credentials=/etc/nixos/smb-secrets"];
  # };
}
