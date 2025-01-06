{pkgs, ...}: {
  fonts = {
    fontconfig = {
      enable = true;
      # use fc-list to list all available fonts
      defaultFonts = {
        monospace = ["MonaspiceNe Nerd Font"];
        sansSerif = ["Lexend Deca"];
        serif = ["Lexend Deca"];
        emoji = [
          "Twitter Color Emoji"
          "Noto Color Emoji"
        ];
      };
    };
    packages = with pkgs; [
      (nerdfonts.override {fonts = ["Monaspace"];})
      corefonts
      noto-fonts
      lexend
      atkinson-hyperlegible

      # fonts for none latin languages
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif

      # emoji
      twemoji-color-font
      noto-fonts-color-emoji
    ];
  };
}
