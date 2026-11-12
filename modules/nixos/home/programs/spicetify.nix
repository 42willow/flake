{
  pkgs,
  inputs,
  osConfig,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in {
  imports = [inputs.spicetify-nix.homeManagerModules.default];

  programs.spicetify = {
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
}
