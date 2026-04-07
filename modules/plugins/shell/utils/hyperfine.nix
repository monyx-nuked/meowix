{
  flake.modules.homeManager."shell.utils.hyperfine" =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.hyperfine
      ];
    };
}
