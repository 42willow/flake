{
  lib,
  config,
  ...
}: {
  programs.tofi = {
    enable = true;
    settings = {
      width = "100%";
      height = "100%";
      border-width = 0;
      outline-width = 0;
      padding-top = "30%";
      padding-bottom = "30%";
      padding-left = "8%";
      padding-right = "8%";
      result-spacing = 25;
      num-results = 5;
      font = "monospace";
      clip-to-padding = true;
      hide-cursor = true;
    };
  };
  home.activation = {
    # https://github.com/philj56/tofi/issues/115#issuecomment-1701748297
    regenerateTofiCache = lib.hm.dag.entryAfter ["writeBoundary"] ''
      tofi_cache=${config.xdg.cacheHome}/tofi-drun
      [[ -f "$tofi_cache" ]] && rm "$tofi_cache"
    '';
  };
}
