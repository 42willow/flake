{pkgs, ...}: {
  # programs.zed-editor = {
  #   enable = true;
  #   package = (pkgs.zed-editor.fhsWithPackages (pkgs: [ pkgs.zlib ])) # Discord RPC requires zlib
  #   userSettings = {
  #     "features" = {
  #       "inline_completion_provider" = "copilot";
  #     };
  #   };
  # };
  home.packages = [
    pkgs.rustfmt # move to settings ({pkgs.rust-analyzer, pkgs.rustfmt})

    (pkgs.zed-editor.fhsWithPackages (pkgs: [ pkgs.zlib ]))
  ];
}
