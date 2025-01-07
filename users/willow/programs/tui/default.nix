{pkgs, ...}: {
  imports = [
    # ./nvim
    ./bat.nix
    ./btop.nix
    ./gitui.nix
    ./ncmpcpp.nix
    ./yazi.nix
  ];

  home.packages = with pkgs; [
    peaclock
  ];
}
