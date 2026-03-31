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
        enable = true;
      };
    };
    homeManager.${moduleName} = {
      imports = [
        inputs.catppuccin.homeManagerModules.catppuccin
      ];
      catppuccin = {
        enable = true;
        accent = "sapphire";
      };
    };
  };
}
