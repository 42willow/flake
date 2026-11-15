{
  pkgs,
  lib,
  self,
  config,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.glide;
in {
  options.nest.services.glide = mkServiceOption "glide window manager" {};

  config = mkIf cfg.enable {
    launchd.user.agents = {
      glide = {
        command = lib.getExe' pkgs.glide "glide_server";

        serviceConfig = {
          KeepAlive = true;
          RunAtLoad = true;
          ProcessType = "Interactive";
          StandardOutPath = "/tmp/glide_wm.out";
          StandardErrorPath = "/tmp/glide_wm.err";
        };
      };
    };
  };
}
