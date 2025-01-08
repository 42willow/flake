{pkgs, ...}: {
  # Keywords:
  #
  # Google         | @google @g
  # YouTube        | @youtube @yt
  # NixOS Packages | @nixpkgs @np
  # NixOS Options  | @nixopts @no
  # NixOS Flakes   | @nixflakes @nf
  # Home Manager   | @homemanager @hm
  # MyNixOS        | @mynixos @mn

  programs.firefox.profiles.default.search = {
    force = true;
    default = "DuckDuckGo";
    engines = {
      "Bing".metaData.hidden = true;
      "Wikipedia (en)".metaData.hidden = true;
      "eBay".metaData.hidden = true;

      "Google".metaData.alias = "@g";

      "YouTube" = {
        definedAliases = ["@youtube" "@yt"];
        iconUpdateURL = "https://www.youtube.com/s/desktop/8b6c1f4c/img/favicon_144x144.png";

        urls = [
          {
            template = "https://www.youtube.com/results";
            params = [
              {
                name = "search_query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };

      "NixOS Packages" = {
        definedAliases = ["@nixpkgs" "@np"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

        urls = [
          {
            template = "https://search.nixos.org/packages";
            params = [
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };

      "NixOS Options" = {
        definedAliases = ["@nixopts" "@no"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

        urls = [
          {
            template = "https://search.nixos.org/options";
            params = [
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };

      "NixOS Flakes" = {
        definedAliases = ["@nixflakes" "@nf"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

        urls = [
          {
            template = "https://search.nixos.org/flakes";
            params = [
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };

      "Home Manager" = {
        definedAliases = ["@homemanager" "@hm"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";

        urls = [
          {
            template = "https://home-manager-options.extranix.com";
            params = [
              {
                name = "query";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };

      "MyNixOS" = {
        definedAliases = ["@mynixos" "@mn"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake-white.svg";

        urls = [
          {
            template = "https://mynixos.com/search";
            params = [
              {
                name = "q";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };
    };
  };
}
