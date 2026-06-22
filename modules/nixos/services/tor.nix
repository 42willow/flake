{
  config,
  lib,
  ...
}: let
  cfg = config.nest.services.networking.tor;
in {
  config = lib.mkIf cfg.enable {
    services.tor = {
      enable = true;
      client.enable = true;
      client.dns.enable = true;
      torsocks.enable = true;
    };
  };
}
