{config, ...}: let
  inherit (config.settings.system) user;
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
