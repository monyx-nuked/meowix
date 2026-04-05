{
  flake.modules.homeManager."shell.utils.rg" =
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
