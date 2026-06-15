{
  lib,
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  cfg = config.nest;
in {
  options.nest.programs = {
    enable = mkEnableOption "programs" // {default = true;};
    cli = mkEnableOption "CLI programs" // {default = true;};
    gui = mkEnableOption "GUI programs" // {default = cfg.desktop.enable;};

    games.enable = mkEnableOption "games";
    media.enable = mkEnableOption "media and creative tools";
    privacy.enable = mkEnableOption "privacy programs";
    productivity.enable = mkEnableOption "productivity programs";
    social.enable = mkEnableOption "social programs";

    browsers = {
      helium.enable = mkEnableOption "helium browser"; # TODO not in nixpkgs yet https://github.com/NixOS/nixpkgs/pull/498572
      firefox.enable = mkEnableOption "firefox browser";
      floorp.enable = mkEnableOption "floorp browser";
      chromium.enable = mkEnableOption "chromium browser";
    };

    terminal = {
      emulator = {
        ghostty.enable = mkEnableOption "ghostty";
        alacritty.enable = mkEnableOption "alacritty";
        kitty.enable = mkEnableOption "kitty";
      };
      shell = {
        atuin.enable = mkEnableOption "atuin shell history";
        starship.enable = mkEnableOption "starship prompt";
        zsh.enable = mkEnableOption "zsh";
        nushell.enable = mkEnableOption "nushell";
        userShell = lib.mkOption {
          type = lib.types.enum ["zsh" "nushell" "bash"];
          default = "zsh";
          description = "The primary interactive shell the user account.";
        };
      };
      tools = {
        enable = mkEnableOption "modern terminal utilities";
        bat.enable = mkEnableOption "bat" // {default = cfg.programs.terminal.tools.enable;};
        eza.enable = mkEnableOption "eza" // {default = cfg.programs.terminal.tools.enable;};
        fzf.enable = mkEnableOption "fzf" // {default = cfg.programs.terminal.tools.enable;};
        ripgrep.enable = mkEnableOption "ripgrep" // {default = cfg.programs.terminal.tools.enable;};
        zoxide.enable = mkEnableOption "zoxide" // {default = cfg.programs.terminal.tools.enable;};
      };
    };

    devtools = {
      enable = mkEnableOption "developer tools";

      haskell.enable = mkEnableOption "haskell tooling";
      nix.enable = mkEnableOption "nix tooling";
      openscad.enable = mkEnableOption "openscad tooling";
      python.enable = mkEnableOption "python tooling";
      rust.enable = mkEnableOption "rust tooling";
      typst.enable = mkEnableOption "typst tooling";
      zig.enable = mkEnableOption "zig tooling";

      web = {
        pnpm.enable = lib.mkEnableOption "pnpm package manager";
        bun.enable = lib.mkEnableOption "bun runtime and toolchain";
      };
    };
  };
}
