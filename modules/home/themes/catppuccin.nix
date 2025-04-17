{inputs, ...}: {
  imports = [
    inputs.catppuccin.homeModules.catppuccin
  ];

  catppuccin = {
    flavor = "macchiato";
    # TODO)) light flavor
    accent = "pink";
    enable = true;
  };
}
