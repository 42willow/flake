{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.gui
    && cfg.media.enable) {
    programs.zathura = {
      enable = false;

      options = {
        selection-clipboard = "clipboard";
        scroll-page-aware = "true";
        scroll-full-overlap = "0.01";
        scroll-step = "100";
        smooth-scroll = true;
        zoom-min = "10";
        guioptions = "none";
      };
    };
  };
}
