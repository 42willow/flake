{osConfig, ...}: {
  programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
    flake = osConfig.settings.system.user.flakeDir;
  };
}
