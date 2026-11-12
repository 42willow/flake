{
  osConfig,
  lib,
  ...
}: {
  config = lib.mkIf osConfig.nest.profiles.graphical.enable {
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style = {
        name = "kvantum";
      };
    };
  };
}
