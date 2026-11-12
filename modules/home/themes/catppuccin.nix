{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    enable = true;

    # https://github.com/catppuccin/nix/pull/477
    flavor = "macchiato";
    accent = "pink";
  };
}
