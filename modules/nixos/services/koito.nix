{
  config,
  inputs,
  pkgs,
  ...
}: {
  imports = ["${inputs.nixos-unstable}/nixos/modules/services/web-apps/koito.nix"];

  services.koito = {
    enable = true;
    package = pkgs.unstable.koito;
    openFirewall = false;

    # https://koito.io/reference/configuration/
    environment = with config.age; {
      KOITO_BIND_ADDR = "0.0.0.0";
      KOITO_LISTEN_PORT = 4110;
      KOITO_DEFUALT_THEME = "catppuccin";
      KOITO_LOGIN_GATE = "false";
      # KOITO_SUBSONIC_URL = "TODO";
      KOITO_SUBSONIC_PARAMS_FILE = secrets.koitoSubsonic.path; # TODO
      KOITO_DEFAULT_USERNAME = "willow"; # TODO
      KOITO_DEFAULT_PASSWORD_FILE = secrets.koitoPassword.path; # TODO
      KOITO_LASTFM_API_KEY_FILE = secrets.lastfm.path;
    };
  };
}
