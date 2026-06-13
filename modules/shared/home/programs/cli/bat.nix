{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.cli) {
    programs.bat.enable = cfg.terminal.tools.bat.enable;
  };
}
