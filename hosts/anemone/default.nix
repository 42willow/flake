{
  modulesPath,
  inputs,
  pkgs,
  ...
}: let
  inherit (inputs) self;
in {
  imports = [
    ./hardware.nix
    inputs.nixos-hardware.nixosModules.raspberry-pi-3
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
    "${self}/modules"
  ];

  disabledModules = ["profiles/base.nix"];

  settings = {
    programs = {
      enable = false;
      cli.enable = true;
      categories = {
        enable = false;
        core.enable = true;
      };
    };
    system = {
      hostName = "anemone";
      services = {
        enable = false;
        networking.enable = true;
      };
    };
    desktop.enable = false;
  };

  services = {
    openssh = {
      enable = true;
      settings = {
        PasswordAuthentication = true;
        PermitRootLogin = "yes";
      };
    };
    klipper = {
      enable = true;
      # user = "klipper";
      # group = "klipper";
      configFile = ./printer.cfg;
    };
    moonraker = {
      enable = true;
    };
    mainsail = {
      enable = true;
    };
  };

  environment.systemPackages = [pkgs.ghostty.terminfo];
}
