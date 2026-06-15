{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.nest;
in {
  options.nest.services = {
    enable = mkEnableOption "core system services" // {default = true;}; # TODO clarify what these are and if this option is needed
    backups = {
      # TODO: move this to shared/
      enable = mkEnableOption "backups via restic";
    };
    bluetooth.enable = mkEnableOption "Bluetooth";
    # not available on darwin
    networking = {
      enable = mkEnableOption "networking" // {default = cfg.system.services.enable;};
      profiles.enable = mkEnableOption "NetworkManager profiles" // {default = true;};
      tailscale.enable = mkEnableOption "tailscale";
      tor.enable = mkEnableOption "tor network";
    };
    # not available on darwin
    printing = {
      enable = mkEnableOption "printing";
      profiles.enable = mkEnableOption "printing profiles" // {default = true;};
    };
    # not available on darwin
    sound.enable = mkEnableOption "sound";
    ssh.enable = mkEnableOption "SSH server";
    syncthing.enable = mkEnableOption "syncthing";

    selfhost = {
      # caddy.enable = mkEnableOption "caddy"; not needed with cloudflared
      mpd.enable = mkEnableOption "mpd";
      kanidm.enable = mkEnableOption "kanidm";
      cloudflared.enable = mkEnableOption "cloudflared";
      pihole.enable = mkEnableOption "pihole"; # TODO or coredns or adguard home for "split horizon DNS" maybe?

      atuin.enable = mkEnableOption "atuin";
      pds.enable = mkEnableOption "pds";
      tangled.knot.enable = mkEnableOption "tangled knot";
      glance.enable = mkEnableOption "tangled knot";
      printing3d = {
        enable = mkEnableOption "3D printing"; # TODO
        klipper.enable = mkEnableOption "klipper";
        mainsail.enable = mkEnableOption "mainsail";
      };
      navidrome.enable = mkEnableOption "navidrome";
    };
  };
}
