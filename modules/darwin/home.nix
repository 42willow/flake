{config, pkgs, ...}: let
  inherit (config.settings.system) user;
in {
  home-manager.users.${user.name} = {
    home.packages = with pkgs; [
      skia-aseprite
    ];
  };
}
