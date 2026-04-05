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
        extraPackages = with pkgs.bat-extras; [
          core
          prettybat
          batwatch
          batpipe
          batman
          batgrep
          batdiff
        ];
      };
      catppuccin.bat = {
        enable = true;
        flavor = "mocha";
      };
    };
}
