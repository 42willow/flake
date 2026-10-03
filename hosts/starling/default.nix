{
  self,
  lib,
  config,
  ...
}: let
  inherit (self.lib) mkSecret;
  cfg = config.settings;
in {
  imports = [
    "${self}/modules/darwin"
    ./stars.nix
  ];

  sops.secrets = {
    syncthing-starling-key = mkSecret {
      file = "syncthing";
      key = "starling/key";
      owner = "willow";
    };
    syncthing-starling-cert = mkSecret {
      file = "syncthing";
      key = "starling/cert";
      owner = "willow";
    };
  };

  networking = {
    computerName = "starling";
    hostName = "starling";
  };

  settings = {
    system = {
      user = let
        home = "/Users/${cfg.system.user.name}";
      in {
        inherit home;
        name = "willow";
        group = "staff";
        flakeDir = "${home}/Documents/git/flake";
      };
      services.sync = with config.sops.secrets; {
        enable = true;
        key = syncthing-starling-key.path;
        cert = syncthing-starling-cert.path;
      };
    };
  };

  nix = {
    linux-builder = {
      enable = true;
      systems = ["aarch64-linux"];
      ephemeral = true;
    };
    settings.trusted-users = ["@admin"];
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-darwin";
}
