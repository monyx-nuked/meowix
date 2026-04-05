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
        extraPackages = [
          pkgs.glow
          pkgs.batman
          pkgs.batdiff
          pkgs.batgrep
          pkgs.batwatch
        ];
      };
      catppuccin.bat = {
        enable = true;
        flavor = "mocha";
      };
    };
}
