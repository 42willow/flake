{
  lib,
  osConfig,
  config,
  ...
}: let
  cfg = osConfig.nest.programs;
in {
  config = lib.mkIf (cfg.cli
    && cfg.terminal.shell.nushell.enable) {
    programs.nushell = {
      enable = true;
      extraConfig = ''
        $env.config = {
          show_banner: false,
          rm: {
            always_trash: true
          }
          ls: {
            clickable_links: true
          }
          completions: {
            case_sensitive: false
            quick: true
            partial: true
            algorithm: "fuzzy"
          }
        }
      '';
      extraEnv = ''
        $env.FLAKE = "${config.home.homeDirectory}/flake"
        $env.PATH = ($env.PATH | split row (char esep)
          | append "~/.cargo/bin")
      '';
    };
  };
}
