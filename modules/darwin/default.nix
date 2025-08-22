{config, ...}: let
  inherit (config.settings.system) user;
in {
  imports = [./desktop ./homebrew.nix ../shared];

  users.users.${user.name}.home = user.home;

  system = {
    stateVersion = 6;

    primaryUser = user.name;

    # https://macos-defaults.com
    defaults = {
      finder = {
        AppleShowAllExtensions = true; # show all file extensions
        FXDefaultSearchScope = "SCcf"; # search current folder by default
        FXEnableExtensionChangeWarning = false; # disable file extension changing warning
        FXPreferredViewStyle = "Nlsv"; # list view
        FXRemoveOldTrashItems = true; # empty bin after 30 days
        QuitMenuItem = true; # allow cmd+q
        ShowPathbar = true; # show breadcrumbs
        ShowStatusBar = true; # bottom status bar
      };
      dock = {
        # hot corners
        wvous-bl-corner = 5; # screen saver
        wvous-br-corner = 10; # put display to sleep
        wvous-tl-corner = 2; # mission control
        wvous-tr-corner = 12; # notification centre
      };
    };
  };

  # touchID for sudo authentication
  security.pam.services.sudo_local.touchIdAuth = true;

  programs.zsh.enable = true;
}
