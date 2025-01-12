{...}: {
  services.gammastep = {
    enable = true;
    tray = true;
    provider = "manual";
    latitude = -38.0;
    longitude = 145.0;
    settings.general.adjustment-method = "wayland";
  };
}
