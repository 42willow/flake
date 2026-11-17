{
  config,
  osConfig,
  lib,
  pkgs,
  ...
}: let
  inherit (osConfig.nest.user) flakeDir;
  inherit (pkgs.stdenv.hostPlatform) isDarwin;

  mkLink = config.lib.file.mkOutOfStoreSymlink;
  settingsFile = mkLink "${flakeDir}/modules/home/programs/glide/glide.toml";
  cfg = osConfig.nest.services.glide;
in {
  config = lib.mkIf (isDarwin && cfg.enable) {
    xdg.configFile."glide/glide.toml".source = settingsFile;
  };
}
