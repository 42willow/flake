{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.cli
    && cfg.devtools.web.bun.enable) {
    programs.bun.enable = true;
  };
}
