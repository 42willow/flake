{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs.categories.web;
in {
  config = lib.mkIf cfg.enable {
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
