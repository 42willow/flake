{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption mkOption types;

  cfg = config.nest;
in {
  options.nest = {
    # TODO: use different namespace
    profile = mkOption {
      type = types.enum ["desktop" "server" "minimal"];
      default = "minimal"; # TODO minimal config is default
      description = "The system profile preset to apply.";
    };

    programs = {
      # no platform namespaces for programs e.g. cli.darwin
      # internal implementation will ignore programs that
      # doesn't
      enable = mkEnableOption "programs";
      cli.enable = mkEnableOption "CLI programs";
      gui.enable = mkEnableOption "GUI programs";

      devtools = {
        enable = mkEnableOption "developer tools";

        haskell.enable = mkEnableOption "haskell tooling";
        nix.enable = mkEnableOption "nix tooling";
        openscad.enable = mkEnableOption "openscad tooling";
        python.enable = mkEnableOption "python tooling";
        rust.enable = mkEnableOption "rust tooling";
        typst.enable = mkEnableOption "typst tooling";
        zig.enable = mkEnableOption "zig tooling";

        web = {
          enable = mkEnableOption "web tooling";
          pnpm.enable = lib.mkEnableOption "pnpm package manager";
          bun.enable = lib.mkEnableOption "bun runtime and toolchain";
        };
      };

      games.enable = mkEnableOption "games";
      media.enable = mkEnableOption "media and creative tools";
      productivity.enable = mkEnableOption "productivity programs";
      social.enable = mkEnableOption "social programs";
      browsers = {
        enable = mkEnableOption "web browsers";
        helium.enable = mkEnableOption "helium browser"; # TODO not in nixpkgs yet https://github.com/NixOS/nixpkgs/pull/498572
        firefox.enable = mkEnableOption "firefox browser";
        floorp.enable = mkEnableOption "floorp browser";
      };

      terminal = {
        emulator = {
          ghostty.enable = mkEnableOption "ghostty";
          alacritty.enable = mkEnableOption "alacritty";
          kitty.enable = mkEnableOption "kitty";
        };
        shell = {
          zsh.enable = mkEnableOption "zsh";
          nushell.enable = mkEnableOption "nushell";
          userShell = lib.mkOption {
            type = lib.types.enum ["zsh" "nushell" "bash"];
            default = "zsh";
            description = "The primary interactive shell the user account.";
          };
        };
      };
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
          default = "${cfg.system.user.home}/flake";
        };
      };

      hostName = mkOption {
        type = types.str;
        description = "The hostname of your system.";
      };

      services = {
        enable = mkEnableOption "core system services";
        backups = {
          # TODO: move this to shared/
          enable = mkEnableOption "backups via restic";
        };
        bluetooth.enable = mkEnableOption "Bluetooth";
        # not available on darwin
        networking = {
          enable = mkEnableOption "networking" // {default = cfg.system.services.enable;};
          profiles.enable = mkEnableOption "NetworkManager profiles" // {default = true;}; # TODO
          tailscale.enable = mkEnableOption "tailscale"; # TODO
          tor.enable = mkEnableOption "TOR network";
        };
        # not available on darwin
        printing = {
          enable = mkEnableOption "printing";
          profiles = mkEnableOption "printing profiles" // {default = true;}; # TODO
        };
        # not available on darwin
        sound.enable = mkEnableOption "sound";
        ssh.enable = mkEnableOption "SSH server";
        sync.enable = mkEnableOption "syncthing";
      };
    };

    desktop = {
      enable = mkEnableOption "desktop environment";
      niri.enable = mkEnableOption "Niri";
      hyprland.enable = mkEnableOption "Hyprland";
    };

    selfhost = {
      enable = mkEnableOption "selfhosted applications";
      # caddy.enable = mkEnableOption "caddy"; not needed with cloudflared
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
