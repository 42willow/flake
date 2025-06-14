# Adapted from https://github.com/isabelroses/dotfiles/blob/main/home/comfy/packages/cli/starship.nix under EUPL-1.2 license
{
  lib,
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

        character = {
          success_symbol = "[❯](pink)";
          error_symbol = "[❯](red)";
        };

        username = {
          style_user = "white";
          style_root = "black";
          format = "[$user]($style) ";
          show_always = false;
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
          symbol = "󰊢 ";
          format = "on [$symbol$branch]($style) ";
          truncation_length = 4;
          truncation_symbol = "…/";
          style = "bold green";
        };

        git_status = {
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

        battery.disabled = true;
      };
    };
  };
}
