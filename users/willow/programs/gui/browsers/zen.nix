{
  osConfig,
  lib,
  inputs,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs.categories.web;
in {
  config = lib.mkIf cfg.enable {
    home.packages = [inputs.zen-browser.packages."${pkgs.system}".default];
  };
}
