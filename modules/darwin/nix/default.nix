{self, ...}: let
  inherit (self) outputs;
in {
  nixpkgs.overlays = [outputs.overlays.darwin-unstable];
}
