{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.dev.enable) {
    programs.bun.enable = true;
  };
}
