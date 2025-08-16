{osConfig, ...}: let
  inherit (osConfig.settings.system) user;
in {
  # imports = [
  #   ./desktop
  #   ./programs
  #   ./scripts
  #   ./services
  #   ./system
  #   ./themes
  # ];
  programs.home-manager.enable = true;

  home = {
    username = user.name;
    homeDirectory = user.home;
    stateVersion = "24.05";
  };
}
