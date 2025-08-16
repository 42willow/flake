{osConfig, ...}: let
  inherit (osConfig.settings.system) mainUser;
in {
  imports = [
    ./desktop
    ./programs
    ./scripts
    ./services
    ./system
    ./themes
  ];
  programs.home-manager.enable = true;

  home = {
    username = "willow";
    homeDirectory = osConfig.users.users.${mainUser}.home;
    stateVersion = "24.05";
  };
}
