{
  flake.modules.homeManager."shell.utils.bat" =
    {
      pkgs,
      ...
    }:
    {
      programs.bat = {
        enable = true;
        extraPackages = with pkgs.bat-extras; [
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
