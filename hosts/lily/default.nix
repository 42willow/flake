{
  self,
  modulesPath,
  inputs,
  pkgs,
  ...
}: let
  targetHost = self.nixosConfigurations.earthy;

  installClosure = pkgs.closureInfo {
    rootPaths = [
      targetHost.config.system.build.toplevel
      targetHost.config.system.build.diskoScript
    ];
  };
in {
  imports = [
    "${modulesPath}/installer/cd-dvd/installation-cd-minimal.nix"
  ];

  nixpkgs.hostPlatform = "x86_64-linux";

  nix.settings.experimental-features = ["nix-command" "flakes"];

  environment = {
    etc."install-closure/store-paths".source = "${installClosure}/store-paths";

    systemPackages = [
      inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko-install
      (pkgs.writeShellScriptBin "install-host" ''
        set -euo pipefail
        FLAKE_REF="''${1:-/etc/nixos}"
        HOST="''${2:-earthy}"
        DISK="''${3:-/dev/nvme0n1}"

        exec ${inputs.disko.packages.${pkgs.stdenv.hostPlatform.system}.disko-install}/bin/disko-install \
          --flake "$FLAKE_REF#$HOST" \
          --disk main "$DISK"
      '')
    ];
  };
}
