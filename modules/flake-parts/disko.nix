{ inputs, ... }:
{
  imports = [
    # add disko module
    inputs.disko.flakeModules.default
  ];

  flake.diskoConfigurations = {
    # placeholder
  };
}
