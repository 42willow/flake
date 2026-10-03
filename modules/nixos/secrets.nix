{inputs, ...}: {
  imports = [inputs.sops.nixosModules.sops];

  sops = {
    age.keyFile = "/var/lib/sops-nix/key.txt";

    # disable importing host ssh keys (we aren't using them)
    age.sshKeyPaths = [];
  };
}
