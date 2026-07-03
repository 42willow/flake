# Adapted from https://github.com/isabelroses/dotfiles/blob/main/home/comfy/packages/cli/starship.nix under EUPL-1.2 license
{
  lib,
  pkgs,
  config,
  osConfig,
  ...
}: let
  cfg = osConfig.settings.programs;
  # ss = symbol: style: {
  #   inherit symbol;
  #   format = "[$symbol ](${style})";
  # };
  ssv = symbol: style: {
    inherit symbol;
    format = "via [$symbol](${style})";
  };

  tomlFormat = pkgs.formats.toml {};
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.core.enable) {
    programs.starship = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;

      settings = {
        add_newline = false;

        format = lib.concatStrings [
          "$cmd_duration"
          "$directory"
          "$all"
          "$fill"
          "\${custom.jj}"
          "$line_break"
          "$character"
        ];

        fill.symbol = " ";

        character = {
          success_symbol = "[](pink)";
          error_symbol = "[](red)";
        };

        username = {
          style_user = "white";
          style_root = "black";
          format = "[$user]($style) ";
          show_always = false;
        };

        custom.jj = {
          command = "prompt";
          format = "$output";
          ignore_timeout = true;
          shell = [
            (lib.getExe pkgs.starship-jj)
            "--ignore-working-copy"
            "starship"
          ];
          use_stdin = false;
          when = true;
        };

        cmd_duration = {
          disabled = true;
          format = "took [$duration]($style)\n";
        };

        directory = {
          truncation_length = 10;
          truncate_to_repo = true;
          read_only_style = "197";
          read_only = "  ";
          format = "[$path]($style)[$read_only]($read_only_style) ";

          # substitutions = {
          # "󰋞 /docs" = "󰈙 ";
          # "󰈙 /school" = "󰑴 ";
          # "󰋞 /downloads" = " ";
          # "󰋞 /tmp" = " ";
          # "󰋞 /media/music" = " ";
          # "󰋞 /media/pictures" = " ";
          # "󰋞 /media/videos" = " ";
          # "󰋞 /media/3dp" = " ";
          # "󰋞 /git" = "󱌢 ";
          # "󰋞 /.config" = " ";
          # };
        };

        # container = ss " 󰏖" "yellow dimmed";
        # python = ss "" "yellow";
        # nodejs = ss " " "yellow";
        # lua = ss "󰢱 " "blue";
        # rust = ss "" "red";
        # java = ss " " "red";
        # c = ss " " "blue";
        # golang = ss "" "blue";
        # docker_context = ss " " "blue";
        bun.disabled = true;

        nix_shell = ssv " " "blue";

        git_branch = {
          disabled = true;
          symbol = "󰊢 ";
          format = "on [$symbol$branch]($style) ";
          # truncation_length = 10;
          # truncation_symbol = "…";
          style = "bold green";
        };
        git_status = {
          disabled = true;
          format = "[\\($all_status$ahead_behind\\)]($style) ";
          style = "bold green";
          conflicted = " ";
          up_to_date = " ";
          untracked = " ";
          ahead = "⇡\${count}";
          diverged = "⇕⇡\${ahead_count}⇣\${behind_count}";
          behind = "⇣\${count}";
          stashed = "󰏗 ";
          modified = " ";
          staged = "[++\\($count\\)](green)";
          renamed = "󰖷 ";
          deleted = " ";
        };
        git_commit.disabled = true;

        battery.disabled = true;
      };
    };

    xdg.configFile."starship-jj/starship-jj.toml".source = tomlFormat.generate "starship-jj.toml" {
      module_separator = " ";
      reset_color = false;

      bookmarks = {
        search_depth = 100;
        exclude = [];
      };

      module = [
        {
          type = "Symbol";
          symbol = "󰘬";
          color = "Green";
        }
        {
          type = "Bookmarks";
          separator = " ";
          color = "Green";
          behind_symbol = "";
          surround_with_quotes = false;
          ignore_empty_commits = "None";
        }
        {
          type = "Commit";
          max_length = 24;
          empty_text = "(no desc.)";
          color = "White";
          surround_with_quotes = false;
        }
        {
          type = "Metrics";
          template = "({changed} {added} {removed})";
          color = "White";
          changed_files.color = "Yellow";
        }
      ];
    };
  };
}
