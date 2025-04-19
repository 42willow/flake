{
  inputs,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.desktop;
in {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  config = lib.mkIf cfg.enable {
    catppuccin = {
      flavor = "macchiato";
      # TODO)) light flavor
      accent = "pink";
      enable = true;
    };
  };
}
