{
  flake.modules.homeManager."shell.utils.xh" =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.xh
      ];
    };
}
