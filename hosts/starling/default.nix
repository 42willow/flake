{
  lib,
  inputs,
  config,
  ...
}: let
  inherit (inputs) self;

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
      user = {
        name = builtins.getEnv "SUDO_USER";
        group = "staff";
        home = "/Users/${cfg.system.user.name}";
      };
    };
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
}
