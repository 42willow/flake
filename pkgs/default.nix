{
  pkgs,
  inputs,
  self,
  ...
}: {
  discord-rpc-lsp = pkgs.callPackage ./discord-rpc-lsp.nix {};
  glide-wm = pkgs.callPackage ./glide-wm.nix {};

  docs = pkgs.callPackage ./docs.nix {inherit inputs self;};
}
