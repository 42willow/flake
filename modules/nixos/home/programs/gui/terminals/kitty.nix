{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.core.enable) {
    programs.kitty = {
      enable = true;
      settings = {
        confirm_os_window_close = 0;
        cursor_blink_interval = 0;
        mouse_hide_wait = 0;
      };
    };
  };
}
