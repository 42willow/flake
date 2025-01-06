{
  config,
  lib,
  ...
}: let
  cfg = config.willow.programs.browsers.floorp;
in {
  options.willow.programs.browsers.floorp = {
    enable =
      lib.mkEnableOption "Floorp configuration"
      // {
        default = false;
      };
  };
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
