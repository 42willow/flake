{
  self,
  lib,
  config,
  ...
}: let
  cfg = config.settings;
in {
  imports = [
    "${self}/modules/darwin"
    ./stars.nix
  ];

  networking = {
    computerName = "starling";
    hostName = "starling";
  };

  settings = {
    system = {
      user = let
        home = "/Users/${cfg.system.user.name}";
      in {
        inherit home;
        name = "willow";
        group = "staff";
        flakeDir = "${home}/Documents/git/flake";
      };
      services.sync.enable = true;
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
