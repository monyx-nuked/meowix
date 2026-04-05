{
  flake.modules.homeManager."shell.utils.fzf" = {
    programs.fzf.enable = true;
    catppuccin.fzf = {
      accent = "red";
      enable = true;
      flavor = "mocha";
    };
  };
}
