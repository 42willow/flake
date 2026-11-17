{
  # todo initial or hashed password file
  # might not need this, they're kept for 10 days
  # boot.tmp.cleanOnBoot = true;

  preservation = {
    enable = true;

    # todo use subvolume
    preserveAt."/persistent" = {
      directories = [
        # todo check what all these do
        "/var/lib/systemd/timers"
        "/var/lib/bluetooth"
        {
          directory = "/var/lib/nixos";
          inInitrd = true;
        }
        {
          directory = "/var/lib/sops-nix";
          inInitrd = true;
        }
      ];
      files = [
        {
          file = "/etc/ssh/ssh_host_ed25519_key";
          inInitrd = true;
        }
        {
          file = "/etc/ssh/ssh_host_ed25519_key.pub";
          inInitrd = true;
        }
        {
          file = "/etc/machine-id";
          inInitrd = true;
        }
      ];
    };
  };

  boot.initrd.systemd.services.rollback-root = {
    description = "archive old @root and create a clean @root subvolume";
    wantedBy = ["initrd.target"];
    after = ["systemd-cryptsetup@cryptroot.service"];
    before = ["sysroot.mount"];
    unitConfig.DefaultDependencies = "no";
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /btrfs_tmp
      mount -o subvol=/ /dev/mapper/cryptroot /btrfs_tmp

      if [[ -e /btrfs_tmp/@root ]]; then
        mkdir -p /btrfs_tmp/@old_roots
        timestamp=$(date --date="@$(stat -c %Y /btrfs_tmp/@root)" "+%Y-%m-%d_%H:%M:%S")
        mv /btrfs_tmp/@root "/btrfs_tmp/@old_roots/$timestamp"
      fi

      btrfs subvolume create /btrfs_tmp/@root
      umount /btrfs_tmp
      rmdir /btrfs_tmp
    '';
  };
}
