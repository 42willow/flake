{
  config,
  pkgs,
  ...
}: {
  services.navidrome = {
    enable = true;
    openFirewall = false;
    settings = {
      MusicFolder = config.xdg.userDirs.music;
      Address = "0.0.0.0";
      Port = 4553;
    };
    plugins = with pkgs.navidromePlugins; [
      discord-rich-presence
    ];
  };
}
