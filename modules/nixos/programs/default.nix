{
  lib,
  config,
  ...
}: {
  imports = [
  ];

  programs = {
    steam.enable = lib.mkDefault config.settings.desktop.enable;
    zsh.enable = true;
  };
}
