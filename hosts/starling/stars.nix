{
  pkgs,
  lib,
  config,
  ...
}: let
  stars = pkgs.writeShellScriptBin "stars" ''
    cd ${config.nest.system.user.flakeDir}
    ${lib.getExe pkgs.just} starling
  '';
in {
  environment.systemPackages = [stars];
}
