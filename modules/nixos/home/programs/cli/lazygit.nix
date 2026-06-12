{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.dev.enable) {
    programs.lazygit.enable = true;
  };
}
