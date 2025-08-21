{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.programs.helix.enable {
    xdg.configFile."moxide/settings.toml".source = ./moxide.toml;
  };
}
