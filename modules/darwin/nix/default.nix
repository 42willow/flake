{self, ...}: let
  inherit (self) outputs;
in {
  nixpkgs.overlays = [outputs.overlays.nixpkgs-unstable];
}
