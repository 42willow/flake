{
  pkgs,
  config,
  lib,
  ...
}: {
  config = lib.mkIf config.services.selfhost.kanidm.enable {
    services.kanidm = {
      package = pkgs.unstable.kanidm; # latest security patches

      server = {
        enable = true;
        settings = let
          domain = "auth.example.com";
          host = "[::]";
          port = 443;
        in {
          version = "2";
          inherit domain;
          origin = "https://${domain}";
          bindaddress = "${host}:${builtins.toString port}"; # TODO
          ldapbindaddress = "${host}:3636"; # TODO
          # tls_chain = "${certDir}/fullchain.pem";
          # tls_key = "${certDir}/key.pem";
        };
      };

      provision = {
        enable = true;

        adminPasswordFile = config.age.secrets.kanidm-admin-password.path; # TODO
        idmAdminPasswordFile = config.age.secrets.kanidm-idm-admin-password.path;

        persons.willow = {
        };

        groups = {
          "forgejo.access" = {};
          "immich.access" = {};
          "linkwarden.access" = {};
          "wakapi.access" = {};

          # others do not support external auth
          # with some we can use cloudflare zero trust with kanidm
          "glance.access" = {};
          "mainsail.access" = {};
          "navidrome.access" = {};
        };
      };
    };
  };
}
