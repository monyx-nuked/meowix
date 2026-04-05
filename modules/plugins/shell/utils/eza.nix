{
  flake.modules.homeManager."shell.utils.eza" = {
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
