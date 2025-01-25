{
  inputs,
  pkgs,
  config,
  ...
}: let
  inherit (config.settings.system) mainUser;
  inherit (inputs) self;

  sshDir = config.home-manager.users.${mainUser}.home.homeDirectory + "/.ssh";
  userGroup = config.users.users.${mainUser}.group;

  # https://github.com/isabelroses/dotfiles/blob/0827bb1893b8072b65c66a6919f8abbe6df9a55a/modules/flake/lib/secrets.nix
  mkSecret = {
    file,
    owner ? "root",
    group ? "root",
    mode ? "400",
    ...
  }: {
    file = "${self}/secrets/${file}.age";
    inherit owner group mode;
  };
in {
  imports = [
    inputs.agenix.nixosModules.default
  ];

  environment.systemPackages = [
    inputs.agenix.packages."${pkgs.system}".default
  ];

  age = {
    identityPaths = [
      "/etc/ssh/ssh_host_ed25519_key"
      "${sshDir}/id_ed25519"
    ];

    secrets = {
      gh = mkSecret {
        file = "gh";
        owner = mainUser;
        group = userGroup;
      };
      gh-pub = mkSecret {
        file = "gh-pub";
        owner = mainUser;
        group = userGroup;
      };
      restic = mkSecret {
        file = "restic";
        owner = mainUser;
        group = userGroup;
      };
      samba = mkSecret {
        file = "samba";
        owner = mainUser;
        group = userGroup;
      };
      wifi = mkSecret {
        file = "wifi";
        owner = mainUser;
        group = userGroup;
      };
      initial-passwd = mkSecret {
        file = "initial-passwd";
        owner = mainUser;
        group = userGroup;
      };
    };
  };
}
