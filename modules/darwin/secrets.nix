{inputs, ...}: {
  imports = [inputs.sops.darwinModules.sops];

  sops = {
    age.keyFile = "/Users/willow/Library/Application\ Support/sops/age/keys.txt";

    # disable importing host ssh keys (we aren't using them)
    age.sshKeyPaths = [];
  };
}
