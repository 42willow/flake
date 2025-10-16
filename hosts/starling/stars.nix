{
  pkgs,
  lib,
  ...
}: let
  stars = pkgs.writeShellScriptBin "stars" ''
    cd ~/Documents/git/flake
    ${lib.getExe pkgs.just} starling
  '';
in {
  environment.systemPackages = [stars];
}
