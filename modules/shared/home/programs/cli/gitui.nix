{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.dev.enable) {
    programs.gitui = {
      enable = true;

      keyConfig = ''
        (
          move_left: Some(( code: Char('n'), modifiers: "" )),
          move_down: Some(( code: Char('e'), modifiers: "" )),
          move_up: Some(( code: Char('i'), modifiers: "" )),
          move_right: Some(( code: Char('o'), modifiers: "" )),
          status_ignore_file: Some(( code: Char('g'), modifiers: "" )),
          edit_file: Some(( code: Char('m'), modifiers: "" )),
          open_options: Some(( code: Esc, modifiers: "" )),
        )
      '';
    };
  };
}
