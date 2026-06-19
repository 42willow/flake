{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption toUpper getAttrFromPath splitString concatStringsSep;
in {
  _module.args.lib' = {
    programType = let
      base = type: {
        programType = type;
        description = null;
        __functor = self: description: self // {inherit description;};
      };
    in {
      cli = base "cli";
      gui = base "gui";
    };

    mkProgramGroup = name: children: {inherit name children;};

    mkProgramOptions = tree: let
      get = path: getAttrFromPath (splitString "." path) config;
      walk = prefix: ancestors:
        builtins.mapAttrs (
          name: value:
            if value ? programType
            then let
              typ = value.programType;
              desc = value.description or "${toUpper typ} program ${name}";
              default =
                config.nest.programs.enable
                && config.nest.programs.${typ}
                && lib.all (x: x) (map get ancestors);
              defaultText =
                "nest.programs.enable and nest.programs.${typ}"
                + lib.optionalString (ancestors != [])
                (" and " + lib.concatStringsSep " and " ancestors);
            in
              {enable = mkEnableOption desc // {inherit default defaultText;};}
              // builtins.removeAttrs value ["programType" "description" "__functor"]
            else if value ? children
            then let
              fullPath = prefix ++ [name];
              ancestorStr = "nest.programs.${concatStringsSep "." fullPath}.enable";
            in
              {enable = mkEnableOption value.name;}
              // walk fullPath (ancestors ++ [ancestorStr]) (value.children or {})
            else if builtins.isAttrs value
            then walk (prefix ++ [name]) ancestors value
            else value
        );
    in
      walk [] [] tree;
  };
}
