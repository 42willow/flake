{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = osConfig.settings.programs;
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.dev.enable) {
    home = let
      inherit (osConfig.settings.system.user) flakeDir;
      mkLink = config.lib.file.mkOutOfStoreSymlink;
      settingsFile = mkLink "${flakeDir}/modules/nixos/programs/gui/zed/settings.json";
      keymapFile = mkLink "${flakeDir}/modules/nixos/programs/gui/zed/keymap.json";
    in {
      packages = [
        (pkgs.unstable.zed-editor.fhsWithPackages (pkgs: [pkgs.zlib]))

        pkgs.rustfmt
        pkgs.nixd
        pkgs.nil
        pkgs.prettierd
        pkgs.kdePackages.qtdeclarative # QML
      ];
      file.".config/zed/settings.json".source = settingsFile;
      file.".config/zed/keymap.json".source = keymapFile;
    };
  };
}
