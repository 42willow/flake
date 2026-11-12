{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;

  cfg = config.settings;
in {
  options.nest = {
    profiles = {
      graphical.enable = mkEnableOption "graphical interface";
      headless.enable = mkEnableOption "headless profile";
      server.enable = mkEnableOption "server-specific modules";
      workstation.enable = mkEnableOption "workstation-specific modules";
      laptop.enable = mkEnableOption "laptop-specific modules";
    };

    system = {
      user = {
        name = mkOption {
          type = types.str;
          description = "The username of the main user for your system";
          default = "willow";
        };
        home = mkOption {
          type = types.path;
          description = "The home directory of the main user for your system";
          default = "/home/${cfg.system.user.name}";
        };
        group = mkOption {
          type = types.str;
          description = "The group of the main user for your system";
          default = "users";
        };
        flakeDir = mkOption {
          type = types.path;
          description = "The directory of this flake, used for symlinks";
          defaultText = "${cfg.system.user.home}/flake";
        };
      };

      hostName = mkOption {
        type = types.str;
        description = "The hostname of your system";
        default = "nixos";
      };
    };
  };
}
