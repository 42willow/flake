{pkgs, ...}: {
  virtualisation = {
    podman = {
      enable = true;
      dockerCompat = true;
    };
    oci-containers.backend = "podman";
  };
  environment.systemPackages = [pkgs.distrobox];
}
