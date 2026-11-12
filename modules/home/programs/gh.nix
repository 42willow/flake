{
  config,
  pkgs,
  ...
}: {
  programs.gh = {
    extensions = [
      config.programs.gh-dash.package
      pkgs.gh-stack
    ];
  };
}
