{
  config,
  pkgs,
  lib,
  ...
}: let
  cfg = config.settings.system.services.backups;
in {
  config = lib.mkIf cfg.enable {
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
        passwordFile = "${config.age.secrets.restic.path}";
        paths = [
          "/mnt/shared/docs"
          "/mnt/shared/git"
          "/mnt/shared/media"
          "/mnt/shared/formulate"
          "/home/willow/.config"
          "/home/willow/.ssh"
          "/home/willow/flake"
          "/etc/ssh"
        ];
        repository = "/mnt/nas/restic";
        timerConfig = {
          OnCalendar = "daily";
          Persistent = true;
        };
        pruneOpts = [
          "--keep-daily 7"
          "--keep-weekly 5"
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
