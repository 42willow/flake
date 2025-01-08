{
  config,
  osConfig,
  lib,
  ...
}: let
  # TODO: move to osConfig
  cfg = config.willow;
in {
  imports = [
    ./desktop
    ./programs
    ./scripts
    ./services
    ./system
    ./themes
  ];

  options.willow = {
    enable =
      lib.mkEnableOption "willow's home configuration"
      // {
        default = true;
      };
  };

  config = lib.mkIf cfg.enable {
    programs.home-manager.enable = true;

    home = {
      username = "willow";
      homeDirectory = osConfig.users.users.willow.home;
      stateVersion = "24.05";
    };

    # TODO: move this elsewhere
    nix.settings = {
      warn-dirty = false;
      allowed-users = ["willow"];
      trusted-users = ["root" "willow"];
    };
    nixpkgs.config.allowUnfree = true;
  };
}
