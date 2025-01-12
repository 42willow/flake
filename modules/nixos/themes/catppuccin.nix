{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];
  catppuccin = {
    flavor = "macchiato";
    accent = "pink";
    cache.enable = true;

    tty.enable = true;
  };
}
