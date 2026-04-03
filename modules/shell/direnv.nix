_: {
  flake.modules.homeManager."shell.direnv" = {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
