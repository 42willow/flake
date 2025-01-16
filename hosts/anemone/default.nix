{
  modulesPath,
  lib,
  inputs,
  ...
}: let
  inherit (lib) mkIf;
  swapSpace = 1;
  swapFile = "/swapfile";
in {
  imports = [
    # TODO)) hardware-configuration!
    inputs.raspberry-pi-nix.nixosModules.raspberry-pi
    (modulesPath + "/installer/scan/not-detected.nix")
    # (modulesPath + "/installer/sd-card/sd-image.nix")
    # (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
    # (modulesPath + "/installer/sd-card/sd-image-aarch64-installer.nix")
    # (modulesPath + "/installer/sd-card/sd-image-raspberrypi.nix")
  ];

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux"; # TODO)) move to hardware-configuration

  raspberry-pi-nix = {
    board = "bcm2711"; # raspberry pi {2, 3, 4}
    # uboot.enable = false; # disable uboot as it just gets stuck
  };
  hardware = {
    raspberry-pi = {
      config = {
        all = {
          base-dt-params = {
            BOOT_UART = {
              value = 1;
              enable = true;
            };
            uart_2ndstage = {
              value = 1;
              enable = true;
            };
          };
          dt-overlays = {
            disable-bt = {
              enable = true;
              params = {};
            };
          };
        };
      };
    };
  };

  # fileSystems."/" = {
  #   device = "/dev/disk/by-label/NIXOS_SD";
  #   fsType = "ext4";
  # };

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
      user = "klipper";
      group = "klipper";
      configFile = ./printer.cfg;
    };
    moonraker = {
      enable = true;
    };
    mainsail = {
      enable = true;
    };
  };

  # networking.wireless.enable = true;

  # sdImage = {
  #   # bzip2 compression takes loads of time with emulation, skip it. Enable this if you're low on space.
  #   compressImage = lib.mkDefault false;
  # };

  # boot.initrd.availableKernelModules = ["usbhid"];

  # boot.loader = {
  #   grub.enable = false;
  #   generic-extlinux-compatible.enable = true;
  #   # raspberryPi.firmwareConfig = ["force_turbo=1"];
  # };
}
