{
  lib,
  osConfig,
  config,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.tools.enable) {
    programs.eza = {
      enable = true;
      icons = "auto";
      git = true;

      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;

      extraOptions = [
        "--group-directories-first"
        "--no-user"
      ];
    };
  };
}
