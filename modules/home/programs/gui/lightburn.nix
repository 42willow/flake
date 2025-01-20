{
  lib,
  osConfig,
  pkgs,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.core.enable) {
    home.packages = [
      (
        let
          lightburn = pkgs.appimageTools.wrapType2 rec {
            name = "lightburn";
            version = "1.7.04";
            src = pkgs.fetchurl {
              url = "https://release.lightburnsoftware.com/LightBurn/Release/LightBurn-v${version}/LightBurn-Linux64-v${version}.AppImage";
              hash = "sha256-rwcZMAMwl7L6rH5tMhfzzNpgawIyLLRspWWAtrnOVMg=";
            };
          };
        in
          pkgs.writeScriptBin "lightburn" ''
            #! ${pkgs.bash}/bin/bash

            export QT_PLUGIN_PATH=""
            export QML_IMPORT_PATH=""
            export QT_QPA_PLATFORM=""

            exec "${lightburn}/bin/lightburn"
          ''
      )
    ];
  };
}
