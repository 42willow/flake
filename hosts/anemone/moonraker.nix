{
  services.moonraker = {
    user = "root";
    enable = true;
    address = "0.0.0.0";
    port = 7125;
    settings = {
      # server = {
      #   max_upload_size = 32768; # in MB
      # };
      octoprint_compat = {};
      history = {};
      authorization = {
        force_logins = true;
        cors_domains = [
          "*.local"
          "*.lan"
          "*://app.fluidd.xyz"
          "*://my.mainsail.xyz"
        ];
        trusted_clients = [
          "10.0.0.0/8"
          "127.0.0.0/8"
          "192.168.1.0/24"
          "::1/128"
          "FC00::/7"
        ];
      };
    };
  };
  networking.firewall.allowedTCPPorts = [7125];
}
