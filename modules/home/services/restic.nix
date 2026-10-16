# nix darwin backup
{
  lib,
  pkgs,
  config,
  self,
  ...
}: let
  inherit (self.lib) mkSecret mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.restic;
in {
  options.nest.services.restic = mkServiceOption "restic" {};

  config = mkIf (cfg.enable && pkgs.stdenv.hostPlatform.isDarwin) {
    sops.secrets.restic-password = mkSecret {
      file = "restic";
      key = "password";
      owner = "restic";
      group = "restic";
      mode = "0440";
    };

    services.restic = {
      enable = true;
      backups.remotebackup = {
        repository = "/mnt/nas/restic"; # TODO
        passwordFile = config.sops.secrets.restic-password.path;

        paths = [
          # synced
          "/Users/willow/docs"
          "/Users/willow/flake"
          "/Users/willow/media"
          "/Users/willow/shared"
          "/Users/willow/tmp"

          # unsynced
          "/Users/willow/Applications"
          "/Users/willow/Library"
          "/Users/willow/Desktop" # TODO remove
          "/Users/willow/Documents" # TODO remove
          "/Users/willow/Downloads" # TODO remove
          "/Users/willow/Pictures" # TODO remove
          "/Users/willow/Videos" # TODO remove

          "/Applications"
        ];

        # TODO share the rest of these options with the nixos module
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 4"
          "--keep-monthly 12"
        ];
        exclude = [
          "/Users/willow/Library/Caches"
          "/Users/willow/Library/Logs"
          "secrets"
          ".cache/"
          # rust
          ".cargo/"
          ".rustup/"
          "target/"
          # node
          "node_modules/"
          # python
          "venv/"
          ".venv/"
        ];
      };
    };
  };
}
