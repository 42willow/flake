{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (osConfig.nest.user) flakeDir;
in {
  xdg.configFile = lib.mkIf config.programs.helix.enable {
    ".prettierrc.json".text = builtins.toJSON (import ./prettier.nix {inherit pkgs;});
    ".dprint.jsonc".text = builtins.toJSON (import ./dprint.nix {inherit pkgs;});
    "moxide/settings.toml".source = ./moxide.toml;
    # "biome/biome.json".text = builtins.toJSON {
    #   "$schema" = "https://biomejs.dev";
    #   html.experimentalFullSupportEnabled = true;
    #   linter = {
    #     enabled = true;
    #     rules = {
    #       recommended = true;
    #       correctness.useSortedClasses = "warn";
    #     };
    #   };
    #   formatter.enabled = true;
    # };
  };

  programs.helix = {
    defaultEditor = true;

    languages = let
      prettier = lang: {
        command = lib.getExe pkgs.prettier;
        args = [
          "--parser"
          lang
        ];
      };
      # biome = {
      #   command = lib.getExe pkgs.unstable.biome;
      #   args = [
      #     "format"
      #     "--stdin-file-path"
      #     "%{buffer_name}"
      #   ];
      # };
      oxfmt = {
        command = lib.getExe pkgs.unstable.oxfmt;
        args = [
          "--stdin-filepath"
          "%{buffer_name}"
        ];
      };
      dprint = {
        command = lib.getExe pkgs.dprint;
        args = [
          "fmt"
          "--stdin"
          "%{buffer_name}"
          "--config"
          "${config.xdg.configHome}/.dprint.jsonc"
        ];
      };
    in {
      language-server = {
        oxlint = {
          command = lib.getExe pkgs.unstable.oxlint;
          args = ["--lsp"];
        };
        # biome = {
        #   command = lib.getExe pkgs.unstable.biome;
        #   args = ["lsp-proxy"];
        # };
        emmet-lsp = {
          command = lib.getExe pkgs.emmet-language-server;
          args = ["--stdio"];
        };
        svelte-lsp = {
          command = lib.getExe pkgs.svelte-language-server;
          args = ["--stdio"];
        };
        vue-lsp = {
          command = lib.getExe pkgs.vue-language-server;
          args = ["--stdio"];
        };
        tailwindcss-lsp = {
          command = lib.getExe pkgs.tailwindcss-language-server;
          args = ["--stdio"];
        };
        astro-lsp = {
          command = lib.getExe pkgs.astro-language-server;
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
        tinymist = {
          command = lib.getExe pkgs.tinymist;
          config = {
            # exportPdf = "onType";
            # outputPath = "$root/target/$dir/$name";
            formatterMode = "typstyle";
            # formatterPrintWidth = 80;
          };
        };
        openscad-lsp = {
          command = lib.getExe pkgs.unstable.openscad-lsp;
          args = ["--stdio"];
        };
        gopls.command = lib.getExe pkgs.gopls;
        discord-rpc-lsp.command = lib.getExe pkgs.discord-rpc-lsp;
        # nil.command = lib.getExe pkgs.nil;
        nixd = {
          command = lib.getExe pkgs.nixd;
          config.nixd = {
            nixpkgs.expr = ''import (builtins.getFlake "${flakeDir}").inputs.nixpkgs { }'';
            options = {
              nixos.expr = ''(builtins.getFlake "${flakeDir}").nixosConfigurations.earthy.options'';
              home-manager.expr = ''(builtins.getFlake "${flakeDir}").nixosConfigurations.earthy.options.home-manager.users.type.getSubOptions [ ]'';
            };
          };
        };
        markdown-oxide.command = lib.getExe pkgs.markdown-oxide;
        rust-analyzer.command = lib.getExe pkgs.rust-analyzer;
        zls.command = lib.getExe pkgs.zls;
        hls.command = lib.getExe' pkgs.haskell-language-server "haskell-language-server-wrapper";
      };
      language = map (lang:
        lang
        // {
          auto-format =
            if (builtins.hasAttr "auto-format" lang) && (lang.auto-format == false)
            then false
            else true;
          language-servers = ["discord-rpc-lsp"] ++ (lang.language-servers or []);
        }) [
        {
          name = "nix";
          language-servers = ["nixd"];
          formatter.command = lib.getExe pkgs.alejandra;
        }
        {
          name = "rust";
          language-servers = ["rust-analyzer"];
          formatter.command = lib.getExe pkgs.rustfmt;
        }
        {
          name = "html";
          language-servers = ["emmet-lsp" "html-lsp"];
          formatter = prettier "html";
        }
        {
          name = "svelte";
          language-servers = ["svelte-lsp" "oxlint"];
          formatter = oxfmt;
        }
        {
          name = "astro";
          language-servers = [
            "astro-lsp"
            "tailwindcss-lsp"
            "emmet-lsp"
            "oxlint"
          ];
          formatter = {
            command = "bunx";
            args = ["prettier" "--stdin-filepath" "%{buffer_name}"];
          };
        }
        {
          name = "markdown";
          language-servers = ["markdown-oxide" "markdown-lsp"];
          formatter = dprint;
          soft-wrap.enable = true;
        }
        {
          name = "typescript";
          language-servers = ["typescript-lsp" "oxlint"];
          formatter = oxfmt;
        }
        {
          name = "javascript";
          language-servers = ["javascript-lsp" "oxlint"];
          formatter = oxfmt;
        }
        {
          name = "css";
          language-servers = ["css-lsp"];
          formatter = prettier "css";
        }
        {
          name = "typst";
          language-servers = ["tinymist"];
          soft-wrap.enable = true;
        }
        {
          name = "openscad";
          language-servers = ["openscad-lsp"];
        }
        {
          name = "json";
          language-servers = ["json-lsp"];
          formatter = dprint;
        }
        {
          name = "toml";
          formatter = dprint;
        }
        {
          name = "yaml";
          formatter = {
            command = lib.getExe pkgs.yamlfmt;
            args = [
              "--in"
              "%{buffer_name}"
            ];
          };
        }
        {
          name = "zig";
          language-servers = ["zls"];
        }
        {
          name = "haskell";
          language-servers = ["hls"];
        }
        {
          name = "vue";
          language-servers = ["vue-lsp"];
        }
        {
          name = "go";
          language-servers = ["gopls"];
          formatter.command = lib.getExe' pkgs.go "gofmt";
        }
        # {
        #   name = "kdl";
        #   formatter = {
        #     command = lib.getExe pkgs.kdlfmt;
        #     args = [
        #       "format"
        #       "--stdin"
        #       "%{buffer_name}"
        #     ];
        #   };
        # }
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

          space = {
            o = ":lsp-workspace-command tinymist.startDefaultPreview";
            w = {
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
}
