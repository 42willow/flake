{
  osConfig,
  lib,
  inputs,
  ...
}: let
  cfg = osConfig.settings.programs.categories.web;
  ffConfig = {
    "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
    "browser.ml.chat.enabled" = false;
    "sidebar.revamp" = true;
    "sidebar.verticalTabs" = true;
    "network.dns.disablePrefetch" = false;
    "network.prefetch-next" = true;
    "network.predictor.enable-prefetch" = true;
  };
in {
  # Inspired by https://github.com/SystematicError/dotfiles/blob/master/users/systematic/modules/firefox.nix

  imports = [
    ./containers.nix
    ./engines.nix
    ./policies.nix
  ];

  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;

      profiles = {
        default.extensions.force = true;
        testing = {
          id = 1;
          extensions.force = true;
          # settings = ffConfig;
        };
        guest = {
          id = 2;
          extensions.force = true;
        };
        willow = {
          id = 3;
          extensions.force = true;
          settings = ffConfig;
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
  };
}
