{
  flake.modules.homeManager."shell.utils.rga" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.ripgrep-all.enable = true;
    };
}
