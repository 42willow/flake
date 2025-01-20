{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.core.enable) {
    programs.bat.enable = true;
  };
}
