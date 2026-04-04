{
  flake.modules.homeManager."dev.direnv" = {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
