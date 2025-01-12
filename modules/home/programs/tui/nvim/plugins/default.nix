{...}: {
  # imports = [
  #   ./copilot.nix
  # ];
  programs.nixvim = {
    colorschemes.catppuccin = {
      enable = true;
      settings = {
        flavour = "macchiato";
      };
    };

    plugins = {
      gitsigns = {
        enable = true;
        settings.signs = {
          add.text = "+";
          change.text = "~";
        };
      };
      copilot-vim.enable = true;
    };
  };
}
