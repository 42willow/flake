{
  osConfig,
  lib,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.dev.enable) {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      languages = {
        language-server = {
          emmet-lsp = {
            command = lib.getExe pkgs.emmet-language-server;
            args = ["--stdio"];
          };
        };
        language = [
          {
            name = "html";
            roots = [".git"];
            language-servers = ["emmet-lsp"];
          }
        ];
      };

      settings = {
        editor = {
          mouse = true;
          line-number = "relative";
          jump-label-alphabet = "neioarstdh";
        };

        keys = {
          normal = {
            n = "move_char_left";
            i = "move_visual_line_up";
            e = "move_visual_line_down";
            o = "move_char_right";
            N = "goto_line_start";
            O = "goto_line_end";
            k = "insert_mode";

            h = "move_next_word_end";
            H = "move_next_long_word_end";

            K = [
              "goto_line_start"
              "insert_mode"
            ];

            I = "keep_selections";

            j = "search_next";
            J = "search_prev";
            E = "join_selections";

            l = "open_below";
            L = "open_above";

            "space".w = {
              # Window Mode
              n = "jump_view_left";
              i = "jump_view_up";
              e = "jump_view_down";
              o = "jump_view_right";

              N = "swap_view_left";
              I = "swap_view_up";
              E = "swap_view_down";
              O = "swap_view_right";

              h = "hsplit";
            };

            g = {
              #goto
              n = "goto_line_start";
              o = "goto_line_end";
            };

            "space".b = {
              n = "goto_previous_buffer";
              o = "goto_next_buffer";
            };
          };
          select = {
            n = "extend_char_left";
            i = "extend_visual_line_up";
            e = "extend_visual_line_down";
            o = "extend_char_right";
            N = "goto_line_start";
            O = "goto_line_end";

            j = "extend_search_next";
            J = "extend_search_prev";
            E = "join_selections";

            A-x = "extend_to_line_bounds";
            X = "extend_line_above";
            x = "extend_line_below";

            k = "insert_mode";
            I = "keep_selections";

            h = "move_next_word_end"; # This was taken from the e key
            H = "move_next_long_word_end"; # This was taken from the e key

            g = {
              n = "goto_line_start";
              o = "goto_line_end";
            };
          };
        };
      };
    };
    # home.packages = [pkgs.helix];
  };
}
