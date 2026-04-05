{
  flake.modules.homeManager."shell.utils.delta" = {
    programs.delta = {
      enable = true;
      enableGitIntegration = true;
      enableJujutsuIntegration = true;
    };
  };
}
