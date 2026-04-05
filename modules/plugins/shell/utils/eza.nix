{
  flake.modules.homeManager."shell.eza" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.eza = {
        enable = true;
        git = true;
        icons = "auto";
      };
      catppuccin.eza = {
        accent = "red";
        enable = true;
        flavor = "mocha";
      };
    };
}
