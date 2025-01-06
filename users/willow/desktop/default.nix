{
  osConfig,
  lib,
  ...
}: {
  imports = [
    ./hyprland
  ];

  options.willow.desktop = {
    enable =
      lib.mkEnableOption "Desktop configuration"
      // {
        default = osConfig.settings.desktop.enable;
      };
  };
}
