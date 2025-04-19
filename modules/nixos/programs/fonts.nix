{
  pkgs,
  config,
  lib,
  ...
}: let
  cfg = config.settings.desktop;
in {
  config = lib.mkIf cfg.enable {
    fonts = {
      fontconfig = {
        enable = true;
        # use fc-list to list all available fonts
        defaultFonts = {
          monospace = ["Maple Mono"];
          sansSerif = ["Lexend Deca"];
          serif = ["Lexend Deca"];
          emoji = [
            "Twitter Color Emoji"
            "Noto Color Emoji"
          ];
        };
      };
      packages = with pkgs; [
        corefonts
        noto-fonts

        # sans serif
        lexend
        atkinson-hyperlegible

        # monospace
        maple-mono-NF
        (nerdfonts.override {fonts = ["Monaspace"];})

        # fonts for none latin languages
        noto-fonts-cjk-sans
        noto-fonts-cjk-serif

        # emoji
        twemoji-color-font
        noto-fonts-color-emoji
      ];
    };
  };
}
