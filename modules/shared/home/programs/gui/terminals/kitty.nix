{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.gui
    && cfg.terminal.emulator.kitty.enable) {
    programs.kitty = {
      enable = false;
      settings = {
        confirm_os_window_close = 0;
        cursor_blink_interval = 0;
        mouse_hide_wait = 0;
      };
    };
  };
}
