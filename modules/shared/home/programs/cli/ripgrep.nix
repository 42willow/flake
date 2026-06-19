{
  lib,
  osConfig,
  ...
}: {
  config = lib.mkIf osConfig.nest.programs.terminal.tools.ripgrep.enable {
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
