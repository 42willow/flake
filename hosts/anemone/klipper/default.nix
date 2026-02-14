{pkgs, ...}: let
  mainsail-config = pkgs.fetchFromGitHub {
    owner = "mainsail-crew";
    repo = "mainsail-config";
    rev = "ff3869a621db17ce3ef660adbbd3fa321995ac42";
    hash = "sha256-gDMAUDqf8no66Jc/jutFNwu7RbD+/qD/6Q6GLWOAA/k=";
  };
in {
  services.klipper = {
    enable = true;
    user = "root";
    group = "root";

    logFile = "/var/lib/klipper/klipper.log";
    mutableConfig = true;
    configDir = "/var/lib/moonraker/config";
    configFile = pkgs.writeText "klipper.cfg" ''
      [include ${mainsail-config}/client.cfg]

      ${builtins.readFile ./printer.cfg}
    '';
  };
}
