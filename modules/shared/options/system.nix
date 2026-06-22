{
  lib,
  config,
  ...
}: let
  inherit (lib) mkOption types;
  cfg = config.nest;
in {
  options.nest.system = {
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
      shell = mkOption {
        type = lib.types.enum ["zsh" "nushell" "bash"];
        default = "zsh";
        description = "The primary interactive shell the user account.";
      };
      flakeDir = mkOption {
        type = types.path;
        default = "${cfg.system.user.home}/flake";
      };
    };
  };
}
