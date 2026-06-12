{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.nest;
in {
  options.nest = {
    # TODO move out of here
    profile = mkOption {
      type = types.nullOr (types.enum ["desktop" "server"]);
      default = null;
      description = "The system profile preset to apply. If null, the system falls back to the minimal defaults.";
    };

    system = {
      hostName = mkOption {
        type = types.str;
        description = "The hostname of your system.";
      };

      user = {
        name = mkOption {
          type = types.str;
          default = "willow";
        };
        home = mkOption {
          type = types.path;
          default = "/home/${cfg.system.user.name}";
        };
        group = mkOption {
          type = types.str;
          default = "users";
        };
        flakeDir = mkOption {
          type = types.path;
          default = "${cfg.system.user.home}/flake";
        };
      };
    };
  };
}
