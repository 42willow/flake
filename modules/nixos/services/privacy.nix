{
  config,
  lib,
  ...
}: let
  cfg = config.nest.services.privacy;
in {
  options.nest.services.privacy = {
    enable =
      lib.mkEnableOption "Privacy"
      // {
        default = config.nest.services.enable;
        defaultText = lib.literalExpression "Whether to enable tor support";
      };
  };

  config = lib.mkIf cfg.enable {
    services.tor = {
      enable = true;
      client.enable = true;
      client.dns.enable = true;
      torsocks.enable = true;
    };
  };
}
