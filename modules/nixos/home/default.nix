{config, ...}: let
  inherit (config.settings.system) user;
in {
  home-manager.users.${user.name} = import ./home.nix;
}
