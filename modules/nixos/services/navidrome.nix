{
  services.navidrome = {
    enable = true;
    openFirewall = false;
    settings = {
      MusicFolder = "/home/willow/media/music"; # TODO declare in options
      Address = "0.0.0.0";
      Port = 4553;
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
}
