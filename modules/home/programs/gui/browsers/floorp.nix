{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs.categories.web;
in {
  config = lib.mkIf cfg.enable {
    programs.floorp = {
      enable = false;
      profiles.default = {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };
}
