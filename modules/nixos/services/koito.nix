{
  config,
  inputs,
  pkgs,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkSecret;
in {
  imports = ["${inputs.nixos-unstable}/nixos/modules/services/web-apps/koito.nix"];

  sops = {
    secrets = {
      koito-username = mkSecret {
        file = "koito";
        key = "username";
      };
      koito-password = mkSecret {
        file = "koito";
        key = "password";
      };
      koito-subsonic-url = mkSecret {
        file = "koito";
        key = "subsonic-url";
      };
      koito-subsonic-params = mkSecret {
        file = "koito";
        key = "subsonic-params";
      };
      koito-lastfm-api-key = mkSecret {
        file = "koito";
        key = "lastfm-api-key";
      };
    };
    templates.koito-env = {
      content = with config.sops.placeholder; ''
        KOITO_DEFAULT_USERNAME="${koito-username}"
        KOITO_DEFAULT_PASSWORD="${koito-password}"
        KOITO_SUBSONIC_URL="${koito-subsonic-url}"
        KOITO_SUBSONIC_PARAMS="${koito-subsonic-params}"
        KOITO_LASTFM_API_KEY="${koito-lastfm-api-key}"
      '';
      owner = "koito";
      group = "koito";
      mode = "0440";
    };
  };

  users = {
    users.koito = {
      isSystemUser = true;
      group = "koito";
    };
    groups.koito = {};
  };

  systemd.services.koito.serviceConfig = {
    DynamicUser = lib.mkForce false;
    User = "koito";
    Group = "koito";
  };

  services.koito = {
    enable = false;
    package = pkgs.unstable.koito;
    openFirewall = false;

    # https://koito.io/reference/configuration/
    environment = {
      KOITO_BIND_ADDR = "0.0.0.0";
      KOITO_LISTEN_PORT = 4110;
      KOITO_DEFAULT_THEME = "catppuccin";
      KOITO_LOGIN_GATE = "false";
    };
    environmentFile = config.sops.templates.koito-env.path;
  };
}
