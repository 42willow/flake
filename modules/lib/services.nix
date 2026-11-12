# inspired by the wonderful isabel roses
# https://github.com/isabelroses/dotfiles/blob/b3b98e3062df6bb28a430be755c0812be8d5bb9c/modules/flake/lib/services.nix
{lib}: let
  inherit (lib.types) str;
  inherit (lib.options) mkOption mkEnableOption;

  mkServiceOption = name: {
    port ? 0,
    host ? "0.0.0.0",
    tailnet ? false,
  }: {
    enable = mkEnableOption "enable the ${name} service";

    host = mkOption {
      type = str;
      default = host;
      description = "the host for ${name} service";
    };

    port = mkOption {
      type = lib.types.port;
      default = port;
      description = "the port for ${name} service";
    };

    tailnet = {
      enable =
        mkEnableOption "enable tailscale serve for the ${name} service"
        // {default = tailnet;};
      name = mkOption {
        type = str;
        default = "svc:${name}";
        defaultText = "svc:name";
        description = "tailscale service name for the ${name} service";
      };
    };
  };
in {
  inherit mkServiceOption;
}
