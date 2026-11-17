{config, ...}: let
  inherit (config.nest) user;
in {
  home-manager.users.${user.name} = {
    imports = [
      ./desktop
      ./programs
      ./services
      ./system
      ./themes
    ];
  };
}
