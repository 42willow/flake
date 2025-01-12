{config, ...}: {
  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/.cargo/bin"
    ];

    sessionVariables = {
      FLAKE = "${config.home.homeDirectory}/flake";
    };
  };
}
