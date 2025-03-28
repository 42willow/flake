{
  osConfig,
  config,
  lib,
  pkgs,
  inputs,
  ...
}: let
  cfg = osConfig.settings.programs;
  pkgs-unstable = import inputs.nixpkgs-unstable {
    system = "x86_64-linux";
    config.allowUnfree = true;
  };
in {
  config = lib.mkIf (cfg.gui.enable
    && cfg.categories.dev.enable) {
    home = let
      mkLink = config.lib.file.mkOutOfStoreSymlink;

      settingsFile = mkLink "${config.home.homeDirectory}/flake/modules/home/programs/gui/zed/settings.json";
    in {
      packages = [
        (pkgs-unstable.zed-editor.fhsWithPackages (pkgs: [pkgs.zlib]))

        pkgs.rustfmt
        pkgs.nixd
        pkgs.nil
        pkgs.prettierd
      ];
      file.".config/zed/settings.json".source = settingsFile;
    };
  };
}
