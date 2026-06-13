{
  lib,
  osConfig,
  config,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.cli
    && cfg.devtools.nix.enable) {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;

      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;
      enableNushellIntegration = config.programs.nushell.enable;
    };
  };
}
