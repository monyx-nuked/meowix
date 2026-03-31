let
  moduleName = "catppuccin";
in
{
  flake.modules = {
    nixos.${moduleName} = {
      catppuccin = {
        accent = "sapphire";
        enable = true;
      };
    };
    homeModules.${moduleName} = {
      catppuccin = {
        accent = "sapphire";
        enable = true;
      };
    };
  };
}
