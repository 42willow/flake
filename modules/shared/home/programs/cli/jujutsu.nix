{
  config,
  osConfig,
  ...
}: {
  programs.jujutsu = {
    enable = true;
    settings = {
      user = {
        name = "willow";
        email = "42willow" + "@" + "pm.me";
      };
      signing = {
        behavior = "own";
        backend = "ssh";
        key = osConfig.age.secrets.gh.path;
        backends.ssh.allowed-signers = "${config.home.homeDirectory}/.ssh/allowed_signers";
      };
      ui.default-command = "log";
    };
  };
}
