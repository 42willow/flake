{config, ...}: let
  inherit (config.settings.system) user;
in {
  home-manager.users.${user.name} = {
    imports = [
      ./packages.nix
      ./paneru.nix
      ./glide-wm.nix
    ];
  };
}
