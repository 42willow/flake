{
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.services.selfhost.radicale.enable {
    services.radicale = {
      enable = true;
      settings = {};
    };
  };
}
