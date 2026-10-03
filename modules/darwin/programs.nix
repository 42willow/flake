{
  lib,
  config,
  pkgs,
  ...
}: let
  cfg = config.settings.programs;
in {
  config = lib.mkIf cfg.gui.enable {
    environment.systemPackages = with pkgs; [
      unstable.aseprite
      sops
    ];
  };
}
