{
  modulesPath,
  inputs,
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

  settings = {
    programs.enable = false;
    system.services = {
      enable = false;
      networking.enable = true;
    };
    desktop.enable = false;
  };

  services = {
    openssh = {
      enable = true;
      settings.PasswordAuthentication = false;
    };
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
}
