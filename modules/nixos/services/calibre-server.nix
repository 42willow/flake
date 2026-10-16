let
  ebooksPath = "/srv/ebooks";
in {
  services.calibre-server = {
    enable = true;
    openFirewall = false;
    host = "0.0.0.0";
    port = 4321;
    user = "calibre-server";
    group = "calibre-server";

    libraries = [ebooksPath];
  };

  systemd.tmpfiles.rules = [
    "d ${ebooksPath} 0777 willow users -"
  ];
}
