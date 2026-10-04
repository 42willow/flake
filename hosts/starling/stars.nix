{
  pkgs,
  lib,
  config,
  ...
}: let
  stars = pkgs.writeShellScriptBin "stars" ''
    cd ${config.settings.system.user.flakeDir}
    ${lib.getExe pkgs.just} starling
  '';
in {
  environment.systemPackages = [stars];
}
