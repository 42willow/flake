{self, ...}: {
  programs.ssh = {
    knownHosts = {
      "anemone" = {
        hostNames = ["10.10.1.245"];
        publicKey = builtins.readFile "${self}/keys/anemone.pub";
      };
    };
    extraConfig = ''
      Host anemone
        HostName 10.10.1.245
        Port 22
    '';
  };
}
