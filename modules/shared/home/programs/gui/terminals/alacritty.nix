{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.gui
    && cfg.terminal.emulator.alacritty.enable) {
    programs.alacritty = {
      enable = true;
      settings = {
        window = {
          padding = {
            x = 15;
            y = 15;
          };
        };
        font.normal.family = "Maple Mono NF";
      };
    };
  };
}
