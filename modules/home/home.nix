{osConfig, ...}: let
  inherit (osConfig.nest.system) user;
in {
  imports = [
    ./packages.nix
    ./programs
    ./scripts
    ./secrets.nix
    ./services
    ./themes
  ];

  programs.home-manager.enable = true;

  home = {
    username = user.name;
    homeDirectory = user.home;
    stateVersion = "24.05";
  };
}
