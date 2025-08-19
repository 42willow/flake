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
      # inherit (osConfig.catppuccin) flavor accent;
      # https://github.com/catppuccin/nix/pull/477
      flavor = "macchiato";
      accent = "pink";

      enable = true;
      zathura.enable = false;
    };
  };
}
