{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.fs.enable) {
    programs.yazi.enable = true;
  };
}
