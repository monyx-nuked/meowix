{ inputs, ... }:
let
  moduleName = "catppuccin";
in
{
  flake.modules = {
    nixos.${moduleName} = {
      imports = [
        inputs.catppuccin.nixosModules.catppuccin
      ];
      catppuccin = {
        accent = "sapphire";
        cache.enable = true;
        enable = true;
      };
    };
    homeManager.${moduleName} = {
      imports = [
        inputs.catppuccin.homeModules.catppuccin
      ];
      catppuccin = {
        enable = true;
        cache.enable = true;
        accent = "sapphire";
      };
    };
  };
}
