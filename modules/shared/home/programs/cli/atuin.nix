{
  config,
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  # TODO: sync and dedicated server
  config = lib.mkIf (cfg.cli
    && cfg.terminal.shell.atuin.enable) {
    programs.atuin = {
      enable = true;

      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
    };
  };
}
