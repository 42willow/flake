{
  self,
  lib,
  config,
  ...
}: let
  inherit (config) nest;
in {
  imports = [
    "${self}/modules/darwin"
    ./stars.nix
    ./users.nix
  ];

  networking = {
    computerName = "starling";
    hostName = "starling";
  };

  nest = {
    system = {
      user = let
        home = "/Users/${nest.system.user.name}";
      in {
        inherit home;
        name = "willow";
        group = "staff";
        flakeDir = "${home}/flake";
      };
    };
    profiles = {
      graphical.enable = true;
      dev.enable = true;
    };
    services = {
      aerospace.enable = false;
      glide.enable = true;
      jankyborders.enable = false;
      skhd.enable = false;
      yabai.enable = false;
    };
  };

  nix = {
    linux-builder = {
      enable = true;
      systems = ["aarch64-linux"];
      ephemeral = true;
    };
    settings.trusted-users = ["@admin"];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
}
