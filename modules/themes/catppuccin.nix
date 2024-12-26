{inputs, ...}: {
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];
  catppuccin = {
    flavor = "macchiato";
    accent = "pink";

    tty.enable = true;
  };
}
