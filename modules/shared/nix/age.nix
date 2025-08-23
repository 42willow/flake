{
  inputs,
  pkgs,
  config,
  ...
}: let
  inherit (inputs) self;
  inherit (config.settings.system) user;

  sshDir = user.home + "/.ssh";

  # https://github.com/isabelroses/dotfiles/blob/0827bb1893b8072b65c66a6919f8abbe6df9a55a/modules/flake/lib/secrets.nix
  mkSecret = {
    file,
    mode ? "400",
    ...
  }: {
    inherit mode;
    inherit (user) group;
    owner = user.name;
    file = "${self}/secrets/${file}.age";
  };
in {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.agenix.packages."${pkgs.system}".default
  ];

  age = {
    identityPaths =
      [
        "/etc/ssh/ssh_host_ed25519_key"
      ]
      ++ (
        if sshDir != null
        then ["${sshDir}/id_ed25519"]
        else []
      );

    secrets = {
      gh = mkSecret {
        file = "gh";
      };
      gh-pub = mkSecret {
        file = "gh-pub";
      };
      lastfm = mkSecret {
        file = "lastfm";
      };
      restic = mkSecret {
        file = "restic";
      };
      samba = mkSecret {
        file = "samba";
      };
      wifi = mkSecret {
        file = "wifi";
      };
    };
  };
}
