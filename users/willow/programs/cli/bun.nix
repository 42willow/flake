{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.dev.enable) {
    programs.bun.enable = true;
  };
}
