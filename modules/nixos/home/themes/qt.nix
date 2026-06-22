{
  osConfig,
  lib,
  ...
}: let
  cfg = osConfig.nest.desktop;
in {
  config = lib.mkIf cfg.enable {
    qt = {
      enable = true;
      platformTheme.name = "kvantum";
      style = {
        name = "kvantum";
      };
    };
  };
}
