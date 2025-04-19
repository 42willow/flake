{lib, ...}: {
  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  sdImage.compressImage = false;
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 80;
  };
}
