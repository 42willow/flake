{
  config,
  pkgs,
  lib,
  ...
}: let
  flake = config.settings.system.user.flakeDir;
  hostName = config.networking.hostName;
in {
  systemd.services.nixos-upgrade = {
    description = "automatically update flake inputs and rebuild nixos";

    environment = {
      JJ_USER = "nixos auto upgrade";
      JJ_EMAIL = "root@${hostName}";
    };

    serviceConfig = {
      Type = "oneshot";
      User = "root";

      ExecStart = let
        jj = "${lib.getExe' pkgs.util-linux "runuser"} -u willow -- jj";
      in
        pkgs.writeShellScript "nixos-upgrade-script" ''
          set -e
          cd ${flake}

          echo "updating flake inputs..."
          nix flake update

          if ${jj} diff flake.lock | grep -q .; then
            echo "flake.lock changes detected; committing flake.lock..."

            ${jj} commit flake.lock -m "flake: update"
          else
            echo "no flake updates found; skipping commit"
          fi

          echo "rebuilding system generation..."
          nixos-rebuild switch --flake ${flake} --print-build-logs
        '';
    };

    path = [
      pkgs.coreutils
      pkgs.util-linux
      pkgs.jujutsu
      pkgs.gitMinimal
      pkgs.nixos-rebuild-ng
      config.programs.ssh.package
      config.nix.package.out
    ];
  };

  systemd.timers.nixos-upgrade = {
    description = "timer for nixos auto upgrade";
    wantedBy = ["timers.target"];
    timerConfig = {
      OnCalendar = "02:00";
      RandomizedDelaySec = "45min";
      FixedRandomDelay = true;
      Persistent = true;
    };
  };
}
