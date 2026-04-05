let
  config = {
    catppuccin = {
      enable = true;
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
