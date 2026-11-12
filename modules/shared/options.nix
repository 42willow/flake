{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;
  inherit (config) nest;
in {
  options.nest = {
    profiles = {
      graphical.enable = mkEnableOption "graphical interface";
      headless.enable = mkEnableOption "headless access"; # todo use this
      dev.enable = mkEnableOption "dev tools";
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
          default = "/home/${nest.system.user.name}";
        };
        group = mkOption {
          type = types.str;
          description = "The group of the main user for your system";
          default = "users";
        };
        flakeDir = mkOption {
          type = types.path;
          description = "The directory of this flake, used for symlinks";
          default = "${nest.system.user.home}/flake";
        };
      };

      hostName = mkOption {
        type = types.str;
        description = "The hostname of your system";
        default = "nixos";
      };
    };

    hardware = {
      printing.enable = mkEnableOption "printing";
      sound.enable = mkEnableOption "sound";
    };
  };
}
