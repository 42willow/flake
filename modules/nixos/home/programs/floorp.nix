{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.settings.programs.categories.web;
in {
  config = lib.mkIf cfg.enable {
    programs.floorp = {
      enable = true;
      profiles.default = {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
    };
  };
}
