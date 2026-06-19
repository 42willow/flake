{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption toUpper getAttrFromPath splitString;
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
      walk = ancestors:
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
            then
              {enable = mkEnableOption value.name;}
              // walk (ancestors ++ ["nest.programs.${name}.enable"]) (value.children or {})
            else if builtins.isAttrs value
            then walk ancestors value
            else value
        );
    in
      walk [] tree;
  };
}
