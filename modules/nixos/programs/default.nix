{
  lib,
  config,
  ...
}: let
  cfg = config.nest.programs;
in{
  imports = [
    ./fonts.nix
  ];

  programs = {
    nh = {
      enable = true;
      clean.enable = true;
      clean.extraArgs = "--keep-since 4d --keep 3";
    };
    steam.enable = cfg.games.enable;
    zsh.enable = cfg.terminal.shell.zsh.enable;
  };
}
