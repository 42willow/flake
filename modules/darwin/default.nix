{
  imports = [ ./homebrew.nix ];

  system = {
    stateVersion = 6;

    primaryUser = builtins.getEnv "SUDO_USER"; # not declarative, needs to be built with impure

    # defaults = {
    # };
  };

  # ouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;
}
