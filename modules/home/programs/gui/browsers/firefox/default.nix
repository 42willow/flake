{
  osConfig,
  lib,
  inputs,
  ...
}: let
  cfg = osConfig.settings.programs.categories.web;
in {
  # Inspired by https://github.com/SystematicError/dotfiles/blob/master/users/systematic/modules/firefox.nix

  imports = [
    ./engines.nix
    ./policies.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.testing = {
        id = 1;
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
      };
      profiles.guest.id = 2;
      profiles.willow = {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        # Firefox Cascade config
        userChrome = ''
          @import '${inputs.firefox-cascade}/chrome/includes/cascade-config.css';
          @import '${inputs.firefox-cascade}/integrations/catppuccin/cascade-macchiato.css';

          @import '${inputs.firefox-cascade}/chrome/includes/cascade-layout.css';
          @import '${inputs.firefox-cascade}/chrome/includes/cascade-responsive.css';
          @import '${inputs.firefox-cascade}/chrome/includes/cascade-floating-panel.css';

          @import '${inputs.firefox-cascade}/chrome/includes/cascade-nav-bar.css';
          @import '${inputs.firefox-cascade}/chrome/includes/cascade-tabs.css';

          @import '${inputs.firefox-cascade}/integrations/tabcenter-reborn/cascade-tcr.css';
        '';
      };
    };
  };
}
