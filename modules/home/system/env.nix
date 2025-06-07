{config, ...}: {
  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.local/bin"
      "${config.home.homeDirectory}/.cargo/bin"
    ];

    sessionVariables = {
      NH_FLAKE = "${config.home.homeDirectory}/flake";
    };
  };
}
