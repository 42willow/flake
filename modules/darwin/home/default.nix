{config, ...}: let
  inherit (config.settings.system) user;
in {
  home-manager.users.${user.name} = {
    imports = [
      ./paneru.nix
      ./glide-wm.nix
    ];
  };
}
