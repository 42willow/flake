{pkgs, ...}: {
  services.displayManager.sddm = {
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
  };
}
