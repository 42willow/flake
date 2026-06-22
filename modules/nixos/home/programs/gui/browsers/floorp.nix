{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.gui && cfg.browsers.chromium.enable) {
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
