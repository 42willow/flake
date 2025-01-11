{pkgs, ...}: {
  services.displayManager.sddm = {
    enable = false; # sddm is being funky
    package = pkgs.kdePackages.sddm;
    wayland.enable = true;
  };
}
