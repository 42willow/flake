{
  config,
  pkgs,
  lib,
  self,
  ...
}: let
  cfg = config.settings.system.services.backups;

  inherit (self.lib) mkSecret;
in {
  config = lib.mkIf cfg.enable {
    sops.secrets.restic-password = mkSecret {
      file = "restic";
      key = "password";
      owner = "restic";
      group = "restic";
      mode = "0440";
    };

    users = {
      users.restic = {
        isSystemUser = true;
        group = "restic";
      };
      groups.restic = {};
    };

    security.wrappers.restic = {
      source = lib.getExe pkgs.restic;
      owner = "restic";
      group = "restic";
      permissions = "u=rwx,g=,o=";
      capabilities = "cap_dac_read_search=+ep";
    };

    services.restic.backups = {
      remotebackup = {
        passwordFile = config.sops.secrets.restic-password.path;
        paths = [
          "/etc/ssh"
          "/home/willow/.config"
          "/home/willow/.ssh"
          "/home/willow/docs"
          "/home/willow/flake"
          "/home/willow/media"
          "/home/willow/shared"
          "/home/willow/tmp"
        ];
        repository = "/mnt/nas/restic";
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
