{
  flake.modules.homeManager."shell.rg" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.ripgrep.enable = true;
    };
}
