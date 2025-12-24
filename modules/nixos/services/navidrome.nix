{config, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = true;

    settings = {
      # TODO: use this value for beets
      MusicFolder = "${config.settings.userDirs.music}/music";
    };
  };
}
