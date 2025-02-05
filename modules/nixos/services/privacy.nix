{
  config,
  lib,
  ...
}: let
  cfg = config.settings.services.privacy;
in {
  options.settings.services.privacy = {
    enable =
      lib.mkEnableOption "Privacy"
      // {
        default = config.settings.services.enable;
        defaultText = lib.literalExpression "Whether to enable tor support";
      };
  };

  config = lib.mkIf cfg.enable {
    # services.tor = {
    #   enable = true;
    #   client.enable = true;
    #   client.dns.enable = true;
    #   torsocks.enable = true;
    # };
  };
}
