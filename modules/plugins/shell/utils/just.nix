{
  flake.modules.homeManager."shell.utils.just" =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.just
        pkgs.just-lsp
      ];
    };
}
