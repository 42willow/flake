{
  pkgs,
  config,
  osConfig,
  lib,
  ...
}: let
  inherit (osConfig.settings.system.user) flakeDir;
  mkLink = config.lib.file.mkOutOfStoreSymlink;
  settingsFile = mkLink "${flakeDir}/modules/home/programs/glide-wm/glide.toml";
in {
  config = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    home.packages = [pkgs.glide-wm];

    xdg.configFile."glide/glide.toml".source = settingsFile;
  };
}
