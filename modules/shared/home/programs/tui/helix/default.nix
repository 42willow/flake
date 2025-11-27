{
  osConfig,
  lib,
  pkgs,
  inputs,
  config,
  ...
}: let
  cfg = osConfig.settings.programs;

  pkgs-unstable = import inputs.darwin-unstable {
    system = "aarch64-darwin";
    config.allowUnfree = true;
  };
in {
  config = lib.mkIf (cfg.tui.enable
    && cfg.categories.dev.enable) {
    xdg.configFile.".prettierrc.json".text = builtins.toJSON (import ./prettier.nix {inherit pkgs;});
    xdg.configFile.".dprint.jsonc".text = builtins.toJSON (import ./dprint.nix {inherit pkgs;});
    xdg.configFile."moxide/settings.toml".source = ./moxide.toml;

    programs.helix = {
      enable = true;
      defaultEditor = true;

      languages = let
        prettier = lang: {
          command = lib.getExe pkgs.nodePackages.prettier;
          args = [
            "--parser"
            lang
            "--config"
            "${config.xdg.configHome}/.prettierrc.json"
          ];
        };

        dprint = {
          command = lib.getExe pkgs.dprint;
          args = [
            "fmt"
            "--config"
            "${config.xdg.configHome}/.dprint.jsonc"
          ];
        };
      in {
        language-server = {
          emmet-lsp = {
            command = lib.getExe pkgs.emmet-language-server;
            args = ["--stdio"];
          };
          svelte-lsp = {
            command = lib.getExe pkgs.svelte-language-server;
            args = ["--stdio"];
          };
          typescript-lsp = {
            command = lib.getExe pkgs.typescript-language-server;
            args = ["--stdio"];
          };
          json-lsp = {
            command = lib.getExe' pkgs.vscode-langservers-extracted "vscode-json-language-server";
            args = ["--stdio"];
          };
          css-lsp = {
            command = lib.getExe' pkgs.vscode-langservers-extracted "vscode-css-language-server";
            args = ["--stdio"];
          };
          html-lsp = {
            command = lib.getExe' pkgs.vscode-langservers-extracted "vscode-html-language-server";
            args = ["--stdio"];
          };
          markdown-lsp = {
            command = lib.getExe' pkgs.vscode-langservers-extracted "vscode-markdown-language-server";
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
            auto-format = true;
            language-servers = ["nil"];
            formatter.command = lib.getExe pkgs.alejandra;
          }
          {
            name = "html";
            auto-format = true;
            language-servers = ["emmet-lsp" "html-lsp"];
            formatter = prettier "html";
          }
          {
            name = "svelte";
            auto-format = true;
            language-servers = ["svelte-lsp"];
            formatter = prettier "html";
          }
          {
            name = "markdown";
            auto-format = true;
            language-servers = ["markdown-oxide" "markdown-lsp"];
            formatter = dprint;
            soft-wrap.enable = true;
          }
          {
            name = "typescript";
            auto-format = true;
            language-servers = ["typescript-lsp"];
            formatter = prettier "html";
          }
          {
            name = "javascript";
            auto-format = true;
            language-servers = ["javascript-lsp"];
            formatter = prettier "html";
          }
          {
            name = "css";
            auto-format = true;
            language-servers = ["css-lsp"];
            formatter = prettier "html";
          }
          {
            name = "typst";
            auto-format = true;
            language-servers = ["tinymist"];
            soft-wrap.enable = true;
          }
          {
            name = "openscad";
            auto-format = true;
            language-servers = ["openscad-lsp"];
          }
          {
            name = "json";
            auto-format = true;
            language-servers = ["json-lsp"];
            formatter = dprint;
          }
          {
            name = "toml";
            auto-format = true;
            formatter = dprint;
          }
          {
            name = "yaml";
            auto-format = true;
            formatter = dprint;
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
