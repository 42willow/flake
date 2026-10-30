{
  virtualisation.oci-containers.containers.uhf-server = {
    image = "swapplications/uhf-server:2.2.0";
    autoStart = true;
    ports = ["0.0.0.0:8000:8000"];
    volumes = [
      "/var/lib/uhf/recordings:/recordings"
    ];
    environment = {
      PORT = "8000";
      ENABLE_COMMERCIAL_DETECTION = "true";
    };
    cmd = ["uhf-server"];
  };

  systemd.tmpfiles.rules = [
    "d /var/lib/uhf/recordings 0755 root root - -"
  ];

  networking.firewall.allowedTCPPorts = [8000];
}
