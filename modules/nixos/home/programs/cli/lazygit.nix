{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf cfg.cli {
    programs.lazygit.enable = true;
  };
}
