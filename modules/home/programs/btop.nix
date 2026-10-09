{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.core.enable) {
    programs.btop.enable = true;
  };
}
