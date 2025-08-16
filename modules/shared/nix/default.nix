{
  pkgs,
  lib,
  ...
}: {
  imports = [
    ./age.nix
  ];

  nix.settings = {
    experimental-features = ["nix-command" "flakes"];
    warn-dirty = false;
    keep-going = true;
    allowed-users = ["willow"];
    trusted-users = ["root" "willow"];

    # cachix
    extra-substituters = ["https://nix-community.cachix.org"];
    extra-trusted-public-keys = ["nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="];
  };

  nixpkgs.config = {
    permittedInsecurePackages = [
      "electron-27.3.11"
      "python3.12-django-3.1.14"
    ];
    allowUnfree = true;
  };
}
