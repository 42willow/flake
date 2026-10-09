{
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  MusicFolder = "/srv/music";
  cfg = config.nest.services.navidrome;
in {
  options.nest.services.navidrome = mkServiceOption "navidrome" {
    port = 4553;
    tailnet = true;
  };

  config = mkIf cfg.enable {
    services.navidrome = {
      enable = true;
      openFirewall = false;
      settings = {
        inherit MusicFolder;
        Address = cfg.host;
        Port = cfg.port;
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
  };

  systemd.tmpfiles.rules = [
    "d /srv/music 0755 willow users -"
  ];
}
