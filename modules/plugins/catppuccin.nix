let
  config = {
    catppuccin = {
      accent = "red";
      enable = true;
      flavor = "mocha";
      cache.enable = true;
    };
  };
in

{
  flake.modules = {
    nixos."catppuccin" = config;
    homeManager."catppuccin" = config;
  };
}
