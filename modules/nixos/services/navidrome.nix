{pkgs, ...}: {
  services.navidrome = {
    enable = true;
    openFirewall = false;
    settings = {
      MusicFolder = "/home/willow/media/music"; # TODO declare in options
      Address = "0.0.0.0";
      Port = 4553;
    };
    plugins = with pkgs.navidromePlugins; [
      discord-rich-presence
    ];
  };
}
