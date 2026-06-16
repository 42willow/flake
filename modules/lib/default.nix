{
  config,
  lib,
  ...
}: let
  inherit (lib) mkEnableOption optionalAttrs toUpper getAttrFromPath setAttrByPath;
in {
  # lib.mkExtensible
  mkProgramOption = {
    name,
    type,
    scope ? [], # e.g. ["terminal" "shell"]
    useGlobalEnable ? true, # whether to respect programs and cli/gui toggles
    default ?
      if useGlobalEnable
      then (config.nest.programs.enable && config.nest.programs.${type})
      else false,
    defaultText ?
      if useGlobalEnable
      then "nest.programs.enable and nest.programs.${type}"
      else null,
  }:
    assert lib.asserts.assertOneOf "mkProgramOption" type ["gui" "cli"];
    let
      optPath = scope ++ [name];
      enablePath = ["nest" "programs"] ++ optPath ++ ["enable"];
    in {
      options = setAttrByPath optPath {
        enable =
          mkEnableOption "${toUpper type} program ${name}"
          // (
            {inherit default;}
            // optionalAttrs (defaultText != null) {inherit defaultText;}
          );
      };
      enable = getAttrFromPath enablePath config;
    };
}
