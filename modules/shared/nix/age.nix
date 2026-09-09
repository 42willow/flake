{
  self,
  inputs,
  pkgs,
  config,
  ...
}: let
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
    inputs.agenix.packages."${pkgs.stdenv.hostPlatform.system}".default
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
      freshrss = mkSecret {file = "freshrss";}; # freshrss password
      koitoPassword = mkSecret {file = "koito-password";}; # koito password
      koitoSubsonic = mkSecret {file = "koito-subsonic";}; # koito subsonic params
      lastfm = mkSecret {file = "lastfm";}; # API key
      restic = mkSecret {file = "restic";}; # encryption password
      sambaNas = mkSecret {file = "samba-nas";}; # NAS samba credentials
      sshPrivate = mkSecret {file = "id_ed25519";}; # ssh private key
      sshPublic = mkSecret {file = "id_ed25519.pub";}; # ssh public key
      wifi = mkSecret {file = "wifi";}; # wifi passwords
    };
  };
}
