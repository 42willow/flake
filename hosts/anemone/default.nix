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
    ./mainsail.nix
    ./moonraker.nix
    ./klipper
    inputs.nixos-hardware.nixosModules.raspberry-pi-3
    (modulesPath + "/installer/scan/not-detected.nix")
    (modulesPath + "/installer/sd-card/sd-image-aarch64.nix")
    "${self}/modules/nixos"
  ];

  disabledModules = ["profiles/base.nix"];

  profile = "server";
  nest = {
    system.hostname = "anemone";
    services.enable = false;
  };

  services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = true;
      PermitRootLogin = "yes";
    };
  };

  networking.firewall = {
    allowedTCPPortRanges = [
      {
        from = 51000;
        to = 51999;
      }
    ]; # vsftpd
    connectionTrackingModules = ["ftp"];
  };

  services.vsftpd = {
    enable = true;
    writeEnable = true;
    localUsers = true;
  };

  environment.systemPackages = [pkgs.ghostty.terminfo];
}
