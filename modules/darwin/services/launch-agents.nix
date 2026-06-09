{
  pkgs,
  lib,
  ...
}: {
  launchd.user.agents = {
    glide = {
      command = lib.getExe' pkgs.glide-wm "glide_server";

      serviceConfig = {
        KeepAlive = true;
        RunAtLoad = true;
        ProcessType = "Interactive";
        StandardOutPath = "/tmp/glide_wm.out";
        StandardErrorPath = "/tmp/glide_wm.err";
      };
    };
  };
}
