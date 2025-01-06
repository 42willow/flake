{
  config,
  lib,
  ...
}: {
  imports = [
    ./firefox # default: enabled
    ./chromium.nix # default: enabled
    ./floorp.nix # default: disabled
  ];

  options.willow.programs.browsers = {
    enable =
      lib.mkEnableOption "Browser configuration"
      // {
        # default = config.willow.desktop.enable;
        # defaultText = lib.literalExpression "config.willow.desktop.enable";
        # TODO
        default = true;
      };
  };
}
