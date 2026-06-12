{lib, ...}: let
  inherit (lib) mkEnableOption;
in {
  desktop = {
    enable = mkEnableOption "desktop environment";
    niri.enable = mkEnableOption "Niri";
    hyprland.enable = mkEnableOption "Hyprland";
  };
}
