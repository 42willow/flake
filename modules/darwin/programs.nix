{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    unstable.aseprite
    sops
  ];
}
