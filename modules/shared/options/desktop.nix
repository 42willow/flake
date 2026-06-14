{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  options.nest.desktop = {
    enable = mkEnableOption "desktop environment";
    niri.enable = mkEnableOption "Niri";
    hyprland.enable = mkEnableOption "Hyprland";
  };
}
