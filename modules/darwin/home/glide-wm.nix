{
  pkgs,
  config,
  osConfig,
  ...
}: let
  inherit (osConfig.settings.system.user) flakeDir;
  mkLink = config.lib.file.mkOutOfStoreSymlink;
  settingsFile = mkLink "${flakeDir}/modules/darwin/home/glide.toml";
in {
  home.packages = [pkgs.glide-wm];

  xdg.configFile."glide/glide.toml".source = settingsFile;
}
