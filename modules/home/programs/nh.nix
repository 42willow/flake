{osConfig, ...}: {
  programs.nh = {
    clean = {
      enable = true;
      extraArgs = "--keep-since 4d --keep 3";
    };
    flake = osConfig.nest.user.flakeDir;
  };
}
