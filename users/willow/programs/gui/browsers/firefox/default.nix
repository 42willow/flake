{
  config,
  lib,
  ...
}: let
  cfg = config.willow.programs.browsers.firefox;
in {
  # Inspired by https://github.com/SystematicError/dotfiles/blob/master/users/systematic/modules/firefox.nix

  imports = [
    ./engines.nix
    ./policies.nix
    # inputs.textfox.homeManagerModules.default
  ];

  # textfox = {
  #   enable = true;
  #   profile = "default";
  # };
  options.willow.programs.browsers.firefox = {
    enable =
      lib.mkEnableOption "Firefox configuration"
      // {
        default = config.willow.programs.browsers.enable;
        defaultText = lib.literalExpression "config.willow.programs.browsers.enable";
      };
  };
  config = lib.mkIf cfg.enable {
    programs.firefox = {
      enable = true;
      profiles.default = {
        settings = {
          "toolkit.legacyUserProfileCustomizations.stylesheets" = true;
        };
        # Firefox Cascade config
        # userChrome = ''
        #   @import '${inputs.firefox-cascade}/chrome/includes/cascade-config-mouse.css';
        #   @import '${inputs.firefox-cascade}/integrations/catppuccin/cascade-macchiato.css';

        #   @import '${inputs.firefox-cascade}/chrome/includes/cascade-layout.css';
        #   @import '${inputs.firefox-cascade}/chrome/includes/cascade-responsive.css';
        #   @import '${inputs.firefox-cascade}/chrome/includes/cascade-floating-panel.css';

        #   @import '${inputs.firefox-cascade}/chrome/includes/cascade-nav-bar.css';
        #   @import '${inputs.firefox-cascade}/chrome/includes/cascade-tabs.css';

        #   :root {
        #     --uc-toolbar-position: 4;
        #     --uc-border-radius: 12px;
        #     --uc-accent-colour: var(--uc-identity-colour-pink);
        #   }
        # '';
      };
    };
  };
}
