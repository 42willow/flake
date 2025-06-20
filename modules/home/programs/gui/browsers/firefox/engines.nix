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
  # Noogle         | @noogle @n

  programs.firefox.profiles.willow.search = {
    force = true;
    default = "ddg";
    engines = {
      "bing".metaData.hidden = true;
      "wikipedia".metaData.hidden = true;
      "ebay".metaData.hidden = true;

      "google".metaData.alias = "@g";

      "youtube" = {
        definedAliases = ["@youtube" "@yt"];
        icon = "https://www.youtube.com/s/desktop/8b6c1f4c/img/favicon_144x144.png";
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

      "NixOS Wiki" = {
        definedAliases = ["@nixwiki" "@nw"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        urls = [
          {
            template = "https://wiki.nixos.org/w/index.php";
            params = [
              {
                name = "channel";
                value = "unstable";
              }
              {
                name = "search";
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

      "Noogle" = {
        definedAliases = ["@noogle" "@n"];
        icon = "${pkgs.nixos-icons}/share/icons/hicolor/scalable/apps/nix-snowflake.svg";
        urls = [
          {
            template = "https://noogle.dev/q";
            params = [
              {
                name = "term";
                value = "{searchTerms}";
              }
            ];
          }
        ];
      };
    };
  };
}
