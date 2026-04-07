let
  config = {
    catppuccin = {
      accent = "sapphire";
      enable = true;
      flavor = "mocha";
      cache.enable = true;
    };
  };
in

{
  flake.modules = {
    nixos."etc.catppuccin" = config;
    homeManager."etc.catppuccin" = config;
  };
}
