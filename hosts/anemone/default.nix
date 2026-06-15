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
    system.hostName = "anemone";
    services.enable = false;
    programs = {
      terminal.tools = {
        enable = false;
        bat.enable = true;
        zoxide.enable = true;
      };
      devtools.enable = false;
    };
  };

  # programs that were previously disabled via categories.*.enable = false
  home-manager.users.willow = {
    programs = {
      yazi.enable = false;
      lazygit.enable = false;
      gitui.enable = false;
    };
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
