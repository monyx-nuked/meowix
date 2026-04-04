{
  flake.modules = {
    nixos."shell.fish" = {
      programs.fish = {
        enable = true;
        useBabelfish = true;
      };
    };
    homeManager."shell.fish" = {
      programs.fish.enable = true;
    };
    darwin."shell.fish" = {
      programs.fish = {
        enable = true;
        useBabelfish = true;
      };
    };
  };
}
