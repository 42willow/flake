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
          helium = gui; # TODO not in nixpkgs yet
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
}
