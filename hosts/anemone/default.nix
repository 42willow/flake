{
  modulesPath,
  lib,
  ...
}: let
  inherit (lib) mkIf;
  swapSpace = 1;
  swapFile = "/swapfile";
in {
  imports = [
    (modulesPath + "/installer/scan/not-detected.nix")
    # (modulesPath + "/installer/sd-card/sd-image.nix")
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
    # (modulesPath + "/installer/sd-card/sd-image-aarch64-installer.nix")
    # (modulesPath + "/installer/sd-card/sd-image-raspberrypi.nix")
  ];

  fileSystems."/" = {
    device = "/dev/disk/by-label/NIXOS_SD";
    fsType = "ext4";
  };

  swapDevices = mkIf (swapSpace != null) [
    {
      device = swapFile;
      size = swapSpace * 1024;
    }
  ];

  services.openssh.enable = true;

  services = {
    klipper = {
      enable = true;
    };
    mainsail = {
      enable = true;
    };
  };

  # sdImage = {
  #   # bzip2 compression takes loads of time with emulation, skip it. Enable this if you're low on space.
  #   compressImage = lib.mkDefault false;
  # };

  boot.initrd.availableKernelModules = ["usbhid"];

  boot.loader = {
    grub.enable = false;
    generic-extlinux-compatible.enable = true;
    # raspberryPi.firmwareConfig = ["force_turbo=1"];
  };
}
