{config, ...}: let
  inherit (config.settings.system) user;
in {
  imports = [./desktop ./homebrew.nix ../shared];

  users.users.${user.name}.home = user.home;

  system = {
    stateVersion = 6;

    primaryUser = user.name;

    # defaults = {
    # };
  };

  # touchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;
}
