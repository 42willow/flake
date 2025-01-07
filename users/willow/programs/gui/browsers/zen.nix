{
  config,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = config.willow.programs.browsers.zen;
in {
  options.willow.programs.browsers.zen = {
    enable =
      lib.mkEnableOption "Zen configuration"
      // {
        default = config.willow.programs.browsers.enable;
        defaultText = lib.literalExpression "config.willow.programs.browsers.enable";
      };
  };
  config = lib.mkIf cfg.enable {
    home.packages = [inputs.zen-browser.packages."${pkgs.system}".default];
  };
}
