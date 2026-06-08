{pkgs, ...}: {
  home.packages = with pkgs; [
    unstable.aseprite
  ];
}
