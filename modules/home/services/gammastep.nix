{...}: {
  services.gammastep = {
    enable = false;
    tray = true;
    provider = "manual";
    latitude = -38.0;
    longitude = 145.0;
    settings.general.adjustment-method = "wayland";
  };
}
