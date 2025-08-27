{
  lib,
  osConfig,
  config,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  # ghostty is broken on darwin
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.core.enable && !pkgs.stdenv.hostPlatform.isDarwin) {
    programs.ghostty = {
      enable = false;
      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;

      settings = {
        gtk-single-instance = true;
        macos-titlebar-style = "hidden";

        font-family = "Maple Mono NF";
      };
    };
  };
}
