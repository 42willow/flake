{
  osConfig,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = osConfig.settings.programs;

  pkgs-unstable = import inputs.darwin-unstable {
    system = "aarch64-darwin";
    config.allowUnfree = true;
  };
in {
  imports = [
    ./moxide.nix
  ];

  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.dev.enable) {
    programs.helix = {
      enable = true;
      defaultEditor = true;

      languages = let
        prettierd = {
          command = lib.getExe pkgs.prettierd;
          args = ["--stdin-filepath" "%{buffer_name}"];
        };
      in {
        language-server = {
          emmet-lsp = {
            command = lib.getExe pkgs.emmet-language-server;
            args = ["--stdio"];
          };
          typescript-lsp = {
            command = lib.getExe pkgs.typescript-language-server;
            args = ["--stdio"];
          };
          css-lsp = {
            command = lib.getExe' pkgs.vscode-langservers-extracted "vscode-css-language-server";
            args = ["--stdio"];
          };
          nil = {
            command = lib.getExe pkgs.nil;
          };
          tinymist = {
            command = lib.getExe pkgs.tinymist;
            config = {
              exportPdf = "onType";
              outputPath = "$root/target/$dir/$name";
              formatterMode = "typstyle";
              formatterPrintWidth = 80;
            };
          };
          openscad-lsp = {
            command = lib.getExe pkgs-unstable.openscad-lsp;
            args = ["--stdio"];
          };

          markdown-oxide.command = lib.getExe pkgs.markdown-oxide;
        };
        language = [
          {
            name = "nix";
            language-servers = ["nil"];
            auto-format = true;
            formatter.command = lib.getExe pkgs.alejandra;
          }
          {
            name = "html";
            roots = [".git"];
            language-servers = ["emmet-lsp"];
            formatter = prettierd;
          }
          {
            name = "markdown";
            language-servers = ["markdown-oxide"];
            soft-wrap.enable = true;
            formatter.command = lib.getExe pkgs.mdformat;
          }
          {
            name = "typescript";
            language-servers = ["typescript-lsp"];
            formatter = prettierd;
          }
          {
            name = "javascript";
            language-servers = ["javascript-lsp"];
            formatter = prettierd;
          }
          {
            name = "css";
            language-servers = ["css-lsp"];
            formatter = prettierd;
          }
          {
            name = "typst";
            language-servers = ["tinymist"];
            soft-wrap.enable = true;
            auto-format = true;
          }
          {
            name = "openscad";
            language-servers = ["openscad-lsp"];
            auto-format = true;
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

            z = {
              e = "scroll_down";
            };

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
              n = "goto_line_start";
              e = "move_line_down";
              i = "move_line_up";
              o = "goto_line_end";
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
              e = "extend_line_down";
              i = "extend_line_up";
              o = "goto_line_end";
            };
          };
        };
      };
    };
  };
}
