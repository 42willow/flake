let
  nickname = "willoboo";
in {
  programs.halloy = {
    enable = true;
    settings = {
      servers = {
        liberachat = {
          inherit nickname;
          channels = [
            "#halloy"
          ];
          server = "irc.libera.chat";
        };
        oftc = {
          inherit nickname;
          channels = [
            "#asahi"
            "#asahi-dev"
          ];
          server = "irc.oftc.net";
        };
        irchighway = {
          inherit nickname;
          channels = [
            "#ebooks"
            "#bookz"
          ];
          server = "irc.irchighway.net";
          dangerously_accept_invalid_certs = true;
        };
      };
    };
  };
}
