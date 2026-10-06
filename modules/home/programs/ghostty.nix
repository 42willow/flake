{
  lib,
  osConfig,
  config,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.core.enable) {
    programs.ghostty = {
      enable = true;

      # ghostty is broken on darwin
      package = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin null;

      enableBashIntegration = config.programs.bash.enable;
      enableFishIntegration = config.programs.fish.enable;
      enableZshIntegration = config.programs.zsh.enable;

      settings = {
        gtk-single-instance = true;
        macos-titlebar-style = "hidden";
        window-padding-x = 15;
        window-padding-y = 15;
        font-family = "Maple Mono NF";
      };
    };
  };
}
