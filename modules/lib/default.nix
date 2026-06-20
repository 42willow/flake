{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption toUpper getAttrFromPath concatStringsSep optionalString;

  traceLogs = false;
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
      # prefix:
      # relative path from tree root
      # grows on every decent (groups + plain attrsets)
      # e.g. ["terminal" "tools"]
      #
      # ancestors:
      # paths of every parent group enable
      # grows on group nodes (mkProgramGroup)
      # e.g. [["nest" "programs" "terminal" "tools" "enable"]]
      #
      # plain attrsets don't add ancestors, but prefix still advances
      walk = prefix: ancestors:
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
                && builtins.all (x: x) (map get ancestors); # all parent groups enabled
              defaultText =
                "nest.programs.enable and nest.programs.${typ}"
                + optionalString (ancestors != [])
                (" and " + concatStringsSep " and " (map (concatStringsSep ".") ancestors));
            in
              trace "PROGRAM: name=${name}, prefix=[${concatStringsSep "," prefix}], ancestors=[${concatStringsSep "; " (map (concatStringsSep ".") ancestors)}], default=${builtins.toString default}"
              {enable = mkEnableOption desc // {inherit default defaultText;};}
              // builtins.removeAttrs value ["programType" "description" "__functor"]
            # group node
            else if value ? children
            then let
              fullPath = prefix ++ [name]; # e.g. ["terminal" "tools" "ripgrep"]
              ancestorPath = ["nest" "programs"] ++ fullPath ++ ["enable"];
            in
              trace "GROUP: name=${value.name}, fullPath=[${concatStringsSep "," fullPath}], ancestorPath=[${concatStringsSep "," ancestorPath}]"
              {enable = mkEnableOption value.name;}
              // walk fullPath (ancestors ++ [ancestorPath]) (value.children)
            # plain attrset (structural grouping without option)
            else if builtins.isAttrs value
            then
              trace "ATTRSET: name=${name}, prefix=[${concatStringsSep "," prefix}] recursing"
              (walk (prefix ++ [name]) ancestors value)
            # pass through unchanged
            else trace "VALUE: name=${name} (non-attrs, passing through)" value
        );
    in
      walk [] [] tree;
  };
}
