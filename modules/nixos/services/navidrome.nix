let
  MusicFolder = "/srv/music";
in {
  services.navidrome = {
    enable = true;
    openFirewall = false;
    settings = {
      inherit MusicFolder;
      Address = "0.0.0.0";
      Port = 4553;
      Scanner.PurgeMissing = "full";
      ExtAuth = {
        Header = "Tailscale-User-Login";
        TrustedSources = "127.0.0.1/32,::1/128";
      };
    };
    # no binary cache :(
    # plugins = with pkgs.navidromePlugins; [
    #   discord-rich-presence
    # ];
  };

  systemd.tmpfiles.rules = [
    "d /srv/music 0755 willow users -"
  ];
}
