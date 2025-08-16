{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  inherit (inputs) self;
in {
  imports = [
    "${self}/modules/darwin"
    "${self}/modules/shared"
  ];

  networking = {
    computerName = "starling";
    hostName = "starling";
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
}
