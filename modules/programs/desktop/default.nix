{lib, ...}: {
  imports = [
    ./hyprland.nix
  ];

  options.settings.desktop = {
    enable =
      lib.mkEnableOption "Desktop configuration"
      // {
        default = true;
        defaultText = lib.literalExpression "Whether to enable desktop support";
      };
  };
}
