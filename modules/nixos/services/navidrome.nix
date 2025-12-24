{config, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = true;

    settings = {
      # TODO: use this value for beets
      MusicFolder = "${config.xdg.userDirs.music}/music";
    };
  };
}
