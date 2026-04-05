{
  flake.modules.homeManager."shell.bat" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.bat = {
        enable = true;
        extraPackages = [ pkgs.bat ];
      };
      catppuccin.bat = {
        enable = true;
        flavor = "mocha";
      };
    };
}
