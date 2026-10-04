{
  lib,
  config,
  ...
}: {
  imports = [
    ./fonts.nix
  ];

  programs = {
    steam.enable = lib.mkDefault config.settings.desktop.enable;
    zsh.enable = true;
  };
}
