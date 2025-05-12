{
  config,
  lib,
  modulesPath,
  pkgs,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  # boot
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        editor = false;
        memtest86.enable = true;
        netbootxyz.enable = true;
      };
      efi.canTouchEfiVariables = true;
    };

    binfmt.emulatedSystems = ["aarch64-linux"];

    initrd.availableKernelModules = ["xhci_pci" "nvme" "usbhid" "usb_storage" "sd_mod"];
    initrd.kernelModules = [];
    kernelModules = ["kvm-intel"];
    extraModulePackages = [];

    supportedFilesystems = ["ntfs"];
  };

  # file systems
  fileSystems = {
    "/" = {
      device = "/dev/disk/by-uuid/75293ea9-4307-498d-96b7-8672bd8dcb83";
      fsType = "ext4";
    };
    "/boot" = {
      device = "/dev/disk/by-uuid/0821-BB6D";
      fsType = "vfat";
      options = ["fmask=0077" "dmask=0077"];
    };
    "/mnt/shared" = {
      device = "/dev/nvme0n1p5";
      fsType = "ntfs";
      options = ["rw" "uid=1000" "gid=100"];
    };
  };
  swapDevices = [];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
        vaapiIntel
      ];
    };
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
    i2c.enable = true; # needed for ddcutil
  };

  services.blueman.enable = true;

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;
  # networking.interfaces.wwan0.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  hardware.cpu.intel.updateMicrocode =
    lib.mkDefault config.hardware.enableRedistributableFirmware;
}
