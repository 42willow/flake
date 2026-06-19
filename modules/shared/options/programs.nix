{
  lib,
  lib',
  config,
  ...
}: let
  inherit (lib) mkEnableOption;
  inherit (lib') mkProgramOptions programType mkProgramGroup;
  cfg = config.nest;
in {
  options.nest.programs =
    {
      enable = mkEnableOption "programs" // {default = true;};
      cli = mkEnableOption "CLI programs" // {default = true;};
      gui = mkEnableOption "GUI programs" // {default = cfg.desktop.enable;};
    }
    // (with programType;
      mkProgramOptions {
        games = mkProgramGroup "games" {};
        media = mkProgramGroup "media and creative tools" {};
        privacy = mkProgramGroup "privacy programs" {};
        productivity = mkProgramGroup "productivity programs" {};
        social = mkProgramGroup "social programs" {};

        browsers = {
          chromium = gui;
          firefox = gui // {extensions.enable = mkEnableOption "firefox extensions";};
          floorp = gui;
          helium = gui;
        };

        terminal = {
          emulator = {
            ghostty = gui;
            alacritty = gui;
            kitty = gui;
          };
          shell = {
            atuin = cli "shell history";
            starship = cli "terminal prompt";
            zsh = cli;
            nushell = cli;
          };
          tools = mkProgramGroup "modern terminal utilities" {
            bat = cli "modern cat";
            eza = cli "modern ls";
            fzf = cli "fuzzy finder";
            ripgrep = cli "modern grep";
            zoxide = cli "modern cd";
          };
        };

        devtools = mkProgramGroup "developer tools" {
          haskell = mkProgramGroup "haskell tooling" {};
          nix = mkProgramGroup "nix tooling" {};
          openscad = mkProgramGroup "openscad tooling" {};
          python = mkProgramGroup "python tooling" {};
          rust = mkProgramGroup "rust tooling" {};
          typst = mkProgramGroup "typst tooling" {};
          zig = mkProgramGroup "zig tooling" {};

          web = mkProgramGroup "web development tooling" {
            pnpm = cli "pnpm package manager";
            bun = cli "bun runtime and toolchain";
          };
        };
      });

  # # note: this isnt used its just for reference as i move to the new schema
  # _ = {
  #   enable = mkEnableOption "programs" // {default = true;};
  #   cli = mkEnableOption "CLI programs" // {default = true;};
  #   gui = mkEnableOption "GUI programs" // {default = cfg.desktop.enable;};

  #   games.enable = mkEnableOption "games";
  #   media.enable = mkEnableOption "media and creative tools";
  #   privacy.enable = mkEnableOption "privacy programs";
  #   productivity.enable = mkEnableOption "productivity programs";
  #   social.enable = mkEnableOption "social programs";

  #   browsers = {
  #     helium.enable = mkEnableOption "helium browser"; # TODO not in nixpkgs yet https://github.com/NixOS/nixpkgs/pull/498572
  #     firefox.enable = mkEnableOption "firefox browser";
  #     floorp.enable = mkEnableOption "floorp browser";
  #     chromium.enable = mkEnableOption "chromium browser";
  #   };

  #   terminal = {
  #     emulator = {
  #       ghostty.enable = mkEnableOption "ghostty";
  #       alacritty.enable = mkEnableOption "alacritty";
  #       kitty.enable = mkEnableOption "kitty";
  #     };
  #     shell = {
  #       atuin.enable = mkEnableOption "atuin shell history";
  #       starship = lib.mkProgramOption {
  #         name = "starship prompt";
  #         type = "cli";
  #       };
  #       zsh.enable = mkEnableOption "zsh";
  #       nushell.enable = mkEnableOption "nushell";
  #       # this doesn't belong here, maybe in system.nix because this is just for programs!
  #       userShell = lib.mkOption {
  #         type = lib.types.enum ["zsh" "nushell" "bash"];
  #         default = "zsh";
  #         description = "The primary interactive shell the user account.";
  #       };
  #     };
  #     tools = {
  #       enable = mkEnableOption "modern terminal utilities";
  #       bat.enable = mkEnableOption "bat" // {default = cfg.programs.terminal.tools.enable;};
  #       eza.enable = mkEnableOption "eza" // {default = cfg.programs.terminal.tools.enable;};
  #       fzf.enable = mkEnableOption "fzf" // {default = cfg.programs.terminal.tools.enable;};
  #       ripgrep.enable = mkEnableOption "ripgrep" // {default = cfg.programs.terminal.tools.enable;};
  #       zoxide.enable = mkEnableOption "zoxide" // {default = cfg.programs.terminal.tools.enable;};
  #     };
  #   };

  #   devtools = {
  #     enable = mkEnableOption "developer tools";

  #     haskell.enable = mkEnableOption "haskell tooling" // {default = cfg.programs.devtools.enable;};
  #     nix.enable = mkEnableOption "nix tooling" // {default = cfg.programs.devtools.enable;};
  #     openscad.enable = mkEnableOption "openscad tooling" // {default = cfg.programs.devtools.enable;};
  #     python.enable = mkEnableOption "python tooling" // {default = cfg.programs.devtools.enable;};
  #     rust.enable = mkEnableOption "rust tooling" // {default = cfg.programs.devtools.enable;};
  #     typst.enable = mkEnableOption "typst tooling" // {default = cfg.programs.devtools.enable;};
  #     zig.enable = mkEnableOption "zig tooling" // {default = cfg.programs.devtools.enable;};

  #     web = {
  #       pnpm.enable = lib.mkEnableOption "pnpm package manager" // {default = cfg.programs.devtools.enable;};
  #       bun.enable = lib.mkEnableOption "bun runtime and toolchain" // {default = cfg.programs.devtools.enable;};
  #     };
  #   };
  # };
}
