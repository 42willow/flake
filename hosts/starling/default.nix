{
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  inherit (inputs) self;
in {
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";

  security.pam.services.sudo_local.touchIdAuth = true;

  system = {
    stateVersion = 6;
  };
}
