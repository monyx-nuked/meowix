{
  flake.modules.homeManager."shell.utils.z" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.zoxide.enable = true;
    };
}
