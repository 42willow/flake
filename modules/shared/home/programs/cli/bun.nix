{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = {
    programs.bun.enable = true;
  };
}
