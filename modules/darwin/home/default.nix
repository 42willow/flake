{config, ...}: let
  inherit (config.nest.system) user;
in {
  home-manager.users.${user.name} = {
    imports = [
      ./packages.nix
      ./paneru.nix
      ./glide-wm.nix
    ];
  };
}
