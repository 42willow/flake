{
  pkgs,
  lib,
  inputs,
  osConfig,
  ...
}: let
  cfg = osConfig.nest.programs;
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  config = lib.mkIf (cfg.gui
    && cfg.media.enable) {
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
      colorScheme = osConfig.catppuccin.flavor;
    };
  };
}
