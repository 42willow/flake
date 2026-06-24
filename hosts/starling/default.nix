{
  inputs,
  pkgs,
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
        envUser = builtins.getEnv "SUDO_USER";
      in {
        inherit home;
        name =
          if envUser != ""
          then envUser
          else "willow";
        group = "staff";
        flakeDir = "${home}/Documents/git/flake";
      };
      services.sync.enable = true;
    };
  };

  # environment.systemPackages = [
  #   inputs.chiri.packages.${pkgs.stdenv.hostPlatform.system}.default
  # ];

  nix = {
    linux-builder = {
      enable = true;
      systems = ["aarch64-linux"];
      # config.boot.binfmt.emulatedSystems = ["x86_64-linux" "aarch64-linux"];
    };
    settings.trusted-users = ["@admin"];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
}
