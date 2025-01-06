{
  config,
  lib,
  ...
}: let
  cfg = config.willow.programs.browsers.chromium;
in {
  options.willow.programs.browsers.chromium = {
    enable =
      lib.mkEnableOption "Chromium configuration"
      // {
        default = config.willow.programs.browsers.enable;
        defaultText = lib.literalExpression "config.willow.programs.browsers.enable";
      };
  };
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
