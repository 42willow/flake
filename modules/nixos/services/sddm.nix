{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = true;
    package = pkgs.kdePackages.sddm;
    # wayland.enable = true;
  };
}
