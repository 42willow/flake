{
  nixpkgs.overlays = [
    (import ./aseprite.nix)
  ];
}
