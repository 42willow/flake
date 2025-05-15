{
  inputs,
  config,
  lib,
  ...
}: let
  cfg = config.settings.desktop;
in {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  config = lib.mkIf cfg.enable {
    catppuccin = {
      flavor = "macchiato";
      accent = "pink";
      cache.enable = true;

      tty.enable = true;
      fcitx5.enable = config.i18n.inputMethod.enable;
    };
  };
}
