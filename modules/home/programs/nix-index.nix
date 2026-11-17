{
  inputs,
  lib,
  pkgs,
  ...
}: {
  imports = lib.singleton inputs.nix-index-database.homeModules.default;

  programs = {
    nix-index.package = lib.mkForce inputs.nix-index-database.packages.${pkgs.stdenv.hostPlatform.system}.nix-index-with-small-db;
    nix-index-database.comma.enable = true;
  };
}
