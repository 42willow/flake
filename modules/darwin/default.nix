{
  # imports = [ ./homebrew.nix ];

  system = {
    stateVersion = 6;

    # defaults = {
    # };
  };

  # ouchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;
}
