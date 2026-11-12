{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.nest.profiles.graphical.enable {
    gtk = {
      enable = true;
      # iconTheme = {
      #   name = "Papirus-Dark";
      #   package = pkgs.catppuccin-papirus-folders.override {
      #     inherit (osConfig.catppuccin) flavor accent;
      #   };
      # };
    };
  };
}
