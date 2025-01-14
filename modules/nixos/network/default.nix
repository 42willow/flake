{
  config,
  pkgs,
  ...
}: {
  networking = {
    hostName = "earthy";
    networkmanager = {
      enable = true;
      # https://github.com/Janik-Haag/nm2nix
      ensureProfiles = {
        environmentFiles = [config.age.secrets.wifi.path];

        # https://github.com/alyraffauf/nixcfg/blob/4ccc90fe11c63702879cf50b888ee460c185400d/common/wifi.nix
        profiles = let
          mkOpenWiFi = ssid: {
            connection.id = "${ssid}";
            connection.type = "wifi";
            ipv4.method = "auto";
            ipv6.addr-gen-mode = "default";
            ipv6.method = "auto";
            wifi.mode = "infrastructure";
            wifi.ssid = "${ssid}";
          };

          mkWPA2WiFi = ssid: psk: (
            (mkOpenWiFi ssid)
            // {
              wifi-security.auth-alg = "open";
              wifi-security.key-mgmt = "wpa-psk";
              wifi-security.psk = "${psk}";
            }
          );
        in {
          "UniFi HD" = mkWPA2WiFi "UniFi HD" "$UNIFI_HD";
          "UniFi 5G" = mkWPA2WiFi "UniFi 5G" "$UNIFI_5G";
        };
      };
    };
    nameservers = ["1.1.1.1"];
    firewall = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [
    networkmanagerapplet
  ];
}
