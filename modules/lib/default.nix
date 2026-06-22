{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption toUpper getAttrFromPath concatStringsSep optionalString;

  traceLogs = true;
  trace = msg: x:
    if traceLogs
    then builtins.trace msg x
    else x;
in {
  _module.args.lib' = {
    # __functor allows a description to be optionally attached
    # e.g. lib'.programType.cli "description" or lib'.programType.cli
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

    # group constructor (so the tree walker knows its a group)
    mkProgramGroup = name: children: {inherit name children;};

    mkProgramOptions = tree: let
      # resolve a list-path against the final merged config
      # e.g. ["nest" "programs" "shell" "git" "enable"]
      get = path: getAttrFromPath path config;

      # walk the tree recursively
      #
      # treePath:
      # relative path from tree root
      # grows on every decent (groups + plain attrsets)
      # e.g. ["terminal" "tools"]
      #
      # parentEnablePaths:
      # paths of every parent group enable
      # grows on group nodes (mkProgramGroup)
      # e.g. [["nest" "programs" "terminal" "tools" "enable"]]
      #
      # plain attrsets don't add parentEnablePaths, but treePath still advances
      walk = treePath: parentEnablePaths:
        builtins.mapAttrs (
          name: value:
            if value ? programType
            # leaf node (program)
            then let
              typ = value.programType;
              desc = value.description or "${toUpper typ} program ${name}";
              default =
                config.nest.programs.enable # global master
                && config.nest.programs.${typ} # type (e.g. nest.programs.cli)
                && builtins.all (x: x) (map get parentEnablePaths); # all parent groups enabled
              defaultText =
                "nest.programs.enable and nest.programs.${typ}"
                + optionalString (parentEnablePaths != [])
                (" and " + concatStringsSep " and " (map (concatStringsSep ".") parentEnablePaths));
            in
              trace "PROGRAM: name=${name}, treePath=[${concatStringsSep "," treePath}], parentEnablePaths=[${concatStringsSep "; " (map (concatStringsSep ".") parentEnablePaths)}], default=${builtins.toString default}"
              {enable = mkEnableOption desc // {inherit default defaultText;};}
              // builtins.removeAttrs value ["programType" "description" "__functor"]
            # group node
            else if value ? children
            then let
              fullPath = treePath ++ [name]; # e.g. ["terminal" "tools" "ripgrep"]
              ancestorPath = ["nest" "programs"] ++ fullPath ++ ["enable"];
            in
              trace "GROUP: name=${value.name}, fullPath=[${concatStringsSep "," fullPath}], ancestorPath=[${concatStringsSep "," ancestorPath}]"
              {enable = mkEnableOption value.name;}
              // walk fullPath (parentEnablePaths ++ [ancestorPath]) (value.children)
            # plain attrset (structural grouping without option)
            else if builtins.isAttrs value
            then
              trace "ATTRSET: name=${name}, treePath=[${concatStringsSep "," treePath}] recursing"
              (walk (treePath ++ [name]) parentEnablePaths value)
            # pass through unchanged
            else trace "VALUE: name=${name} (non-attrs, passing through)" value
        );
    in
      walk [] [] tree;
  };
}
