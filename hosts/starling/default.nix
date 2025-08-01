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

  system = {
    stateVersion = 6;
  };
}
