{
  flake.modules.homeManager."shell.utils.fzf" =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      programs.fzf.enable = true;
      catppuccin.fzf = {
        accent = "red";
        enable = true;
        flavor = "mocha";
      };
    };
}
