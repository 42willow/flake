{
  lib,
  osConfig,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.cli.enable
    && cfg.categories.tools.enable) {
    programs.ripgrep = {
      enable = true;

      # https://github.com/BurntSushi/ripgrep/blob/master/GUIDE.md#configuration-file
      arguments = [
        "--max-columns=150"
        "--max-columns-preview"
        "--glob=!.git/*"
        "--smart-case"
      ];
    };
  };
}
