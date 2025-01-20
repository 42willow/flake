{
  lib,
  config,
  ...
}: {
  imports = [
    ./fonts.nix
  ];

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };
    steam.enable = lib.mkDefault config.nest.desktop.enable;
    zsh.enable = true;
  };
}
