{config, ...}: {
  programs.delta = {
    enable = true;
    enableGitIntegration = config.programs.git.enable;
    enableJujutsuIntegration = config.programs.jujutsu.enable;
  };
}
