{
  self,
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = [inputs.sops.homeManagerModules.sops];

  config = {
    sops = {
      defaultSopsFile = "${self}/secrets/willow.yaml";
      age.keyFile =
        if pkgs.stdenv.hostPlatform.isDarwin
        then "/Users/willow/Library/Application\ Support/sops/age/keys.txt"
        else "${config.xdg.configHome}/sops/age/keys.txt";

      secrets = {
        keys-ssh = {};
      };
    };
  };
}
