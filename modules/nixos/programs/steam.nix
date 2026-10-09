{
  lib,
  config,
  ...
}: {
  programs.steam = {
    enable = lib.mkDefault config.settings.desktop.enable;
  };
}
