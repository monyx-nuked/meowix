{
  flake.modules.homeManager."shell.utils.tldr" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.tealdeer.enable = true;
    };
}
