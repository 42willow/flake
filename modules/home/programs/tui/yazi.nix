{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.fs.enable) {
    programs.yazi.enable = true;
  };
}
