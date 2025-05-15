{
  pkgs,
  inputs,
  ...
}: {
  imports = [inputs.niri.nixosModules.niri];
  niri-flake.cache.enable = true;
  nixpkgs.overlays = [inputs.niri.overlays.niri];

  # build first with niri disabled, then enable after cache is added
  programs.niri = {
    enable = true;
    package = pkgs.niri-unstable;
  };
}
