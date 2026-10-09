{
  pkgs,
  config,
  self,
  lib,
  ...
}: let
  inherit (self.lib) mkServiceOption;
  inherit (lib) mkIf;

  cfg = config.nest.services.yabai;
in {
  options.nest.services.yabai = mkServiceOption "yabai" {};

  config = mkIf cfg.enable {
    services.yabai = {
      enable = false;
      package = pkgs.unstable.yabai;
      enableScriptingAddition = true;
      config = {
        focus_follows_mouse = "autoraise";
        mouse_modifier = "fn";
        mouse_action1 = "move";
        mouse_action2 = "resize";
        layout = "bsp";
        top_padding = 12;
        bottom_padding = 12;
        left_padding = 12;
        right_padding = 12;
        window_gap = 12;
        window_shadow = "off";
      };
    };
  };
}
