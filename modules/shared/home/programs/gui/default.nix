{pkgs, ...}: {
  imports = [
    ./terminals
    ./halloy.nix
    ./sioyek.nix
    ./zathura.nix
  ];

  home.packages = [
    pkgs.unstable.chiri
  ];
}
