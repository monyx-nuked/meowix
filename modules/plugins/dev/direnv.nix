{
  flake.modules.homeManager."dev.direnv" = {
    direnv = {
      enable = true;
      nix-direnv.enable = true;
      silent = true;
    };
  };
}
