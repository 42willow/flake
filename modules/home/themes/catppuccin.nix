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
      inherit (osConfig.catppuccin) flavor accent;
      enable = true;
    };
  };
}
