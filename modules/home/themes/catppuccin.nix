{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin = {
    flavor = "macchiato";
    # TODO)) light flavor
    accent = "pink";
    enable = true;
  };
}
