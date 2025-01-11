{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.dev.enable) {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor.fhsWithPackages (pkgs: [pkgs.zlib]); # Discord RPC requires zlib
      userSettings = {
        assistant = {
          default_model = {
            provider = "copilot_chat";
            model = "gpt-4o";
          };
          version = "2";
        };

        tab_size = 2;
        ensure_final_newline_on_save = true;
        remove_trailing_whitespace_on_save = true;

        ui_font_size = 16;
        ui_font_family = "Maple Mono";
        buffer_font_size = 16;
        buffer_font_family = "Maple Mono";
        terminal_font_size = 16;
        terminal_font_family = "Maple Mono";

        languages = {
          Python = {
            editor = {
              tab_size = 4;
              format_on_save = true;
            };
          };
          Rust = {
            editor = {
              tab_size = 4;
            };
          };
          Markdown = {
            editor = {
              remove_trailing_whitespace_on_save = false;
            };
          };
          Nix = {
            language_severs = [
              "nil"
              "!nixd"
            ];
            formatter = {
              external = {
                command = "alejandra";
              };
            };
          };
        };
      };
    };
    home.packages = [
      pkgs.rustfmt
      pkgs.nixd
      pkgs.nil
    ];
  };
}
