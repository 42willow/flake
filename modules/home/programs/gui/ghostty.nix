{
  lib,
  osConfig,
  config,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.core.enable) {
    programs.ghostty = {
      enable = true;
      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;

      settings = {
        gtk-single-instance = true;
        font-family = "Maple Mono NF";
      };
    };
  };
}
