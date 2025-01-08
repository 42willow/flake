{
  pkgs,
  lib,
  inputs,
  osConfig,
  ...
}: let
  cfg = osConfig.settings.programs;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.music.enable) {
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (lib.getName pkg) ["spotify"];

    programs.spicetify = {
      enable = true;
      enabledExtensions = with spicePkgs.extensions; [
        adblock
        hidePodcasts
        shuffle
      ];
      enabledCustomApps = with spicePkgs.apps; [lyricsPlus newReleases];
      enabledSnippets = with spicePkgs.snippets; [
        pointer
        smoothProgressBar
        removePopular
        hideDownloadButton
        removeTopSpacing
      ];
      theme = spicePkgs.themes.catppuccin;
      colorScheme = "macchiato";
    };
  };
}
