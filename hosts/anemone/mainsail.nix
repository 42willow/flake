{pkgs, ...}: let
  mainsail-config = pkgs.fetchFromGitHub {
    owner = "mainsail-crew";
    repo = "mainsail-config";
    rev = "ff3869a621db17ce3ef660adbbd3fa321995ac42";
    hash = "sha256-gDMAUDqf8no66Jc/jutFNwu7RbD+/qD/6Q6GLWOAA/k=";
  };
in {
  services.mainsail = {
    enable = true;
  };
  networking.firewall.allowedTCPPorts = [80];
  environment.etc."mainsail.cfg".source = "${mainsail-config}/client.cfg";
}
