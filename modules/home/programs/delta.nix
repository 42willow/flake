{config, ...}: {
  programs.delta = {
    enableGitIntegration = config.programs.git.enable;
    enableJujutsuIntegration = config.programs.jujutsu.enable;
  };
}
