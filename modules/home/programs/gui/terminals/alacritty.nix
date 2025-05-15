{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.core.enable) {
    programs.alacritty = {
      enable = true;
    };
  };
}
