{pkgs, ...}: {
  imports = [
    # ./nvim
    ./bat.nix # core
    ./btop.nix # core
    ./gitui.nix # dev
    ./ncmpcpp.nix # music
    ./yazi.nix # files
  ];

  home.packages = with pkgs; [
    peaclock
  ];
}
