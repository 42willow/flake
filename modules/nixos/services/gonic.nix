{
  services.gonic = {
    enable = true;
    settings = {
      cache-path = "/var/cache/gonic";
      listen-addr = "0.0.0.0:4747";
      music-path = "/srv/music";
      podcast-path = "/srv/podcasts";
      playlists-path = "/var/lib/gonic/playlists";
    };
  };

  systemd.tmpfiles.rules = [
    "d /srv/music 0755 willow users -"
    "d /srv/podcasts 0777 willow users -"
    "d /var/lib/gonic/playlists 0777 willow users -"
  ];
}
