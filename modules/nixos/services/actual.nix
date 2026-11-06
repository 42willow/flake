{pkgs, ...}: {
  services.actual = {
    enable = true;
    package = pkgs.unstable.actual-server;
    openFirewall = false;

    settings = {
      port = 5006;
      hostname = "127.0.0.1";
    };
  };
}
