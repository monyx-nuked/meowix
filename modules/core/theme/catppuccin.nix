_: {
  flake.modules = {
    nixos."theme.catppuccin" = {
      catppuccin = {
        accent = "sapphire";
        cache.enable = true;
        enable = true;
      };
    };
    homeManager."theme.catppuccin" = {
      catppuccin = {
        enable = true;
        cache.enable = true;
        accent = "sapphire";
      };
    };
  };
}
