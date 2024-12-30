{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  catppuccin = {
    flavor = "macchiato";
    accent = "pink";

    enable = true;
    zed.enable = false;
  };
}
