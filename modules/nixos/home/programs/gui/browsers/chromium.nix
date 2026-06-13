{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.gui && cfg.browsers.chromium.enable) {
    programs.chromium = {
      enable = true;
      extensions = [
        {id = "cjpalhdlnbpafiamejdnhcphjbkeiagm";} # ublock origin
        {id = "denkadefchjkchlefgfhdmabagdcefhf";} # schooltape
        {id = "gebbhagfogifgggkldgodflihgfeippi";} # return youtube dislike
        {id = "cmpdlhmnmjhihmcfnigoememnffkimlk";} # catppuccin macchiato theme
        {id = "lnjaiaapbakfhlbjenjkhffcdpoompki";} # catppuccin for github file explorer icons
        {id = "oboonakemofpalcgghocfoadofidjkkk";} # keepassxc
      ];
    };
  };
}
