{
  lib,
  pkgs,
  inputs,
  self ? inputs.self,
  nixosOptionsDoc,
  runCommand,
}: let
  inherit (lib.attrsets) filterAttrs;
  inherit (lib.modules) evalModules;
  inherit (lib.strings) removePrefix;

  gitHubDeclaration = user: repo: subpath: {
    url = "https://github.com/${user}/${repo}/blob/main/${subpath}";
    name = subpath;
  };

  eval = evalModules {
    modules = [
      (self + /modules/shared/options/default.nix)
      {
        _module = {
          check = false;
          args = {inherit pkgs;};
        };
      }
    ];

    specialArgs = {
      inherit self inputs;
    };
  };

  doc = nixosOptionsDoc {
    options = filterAttrs (n: _: n != "_module") eval.options.settings;
    documentType = "none";
    transformOptions = opt:
      opt
      // {
        declarations =
          map (
            decl:
              if lib.hasPrefix (toString self) (toString decl)
              then
                gitHubDeclaration "42willow" "flake" (
                  removePrefix "/" (removePrefix (toString self) (toString decl))
                )
              else decl
          )
          opt.declarations;
      };
  };
in
  runCommand "flake-options-docs" {} ''
      mkdir -p $out
      cat > $out/options.md << 'EOF'
    # Flake Configuration Options

    EOF
      cat ${doc.optionsCommonMark} >> $out/options.md
  ''
