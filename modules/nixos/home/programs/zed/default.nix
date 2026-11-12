{
  osConfig,
  config,
  lib,
  pkgs,
  ...
}: {
  options.programs.zed.enable = lib.mkEnableOption "zed editor";

  config = lib.mkIf config.programs.zed.enable {
    home = let
      inherit (osConfig.nest.system.user) flakeDir;
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
