{
  flake.modules.homeManager."shell.utils.fd" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.fd.enable = true;
    };
}
