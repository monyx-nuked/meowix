{ inputs, ... }:
{
  imports = [
    # This module provides a generic modules flake output attribute, that can host modules for any module system application.
    # TODO: Later research what does this mean
    # inputs.flake-parts.flakeModules.modules
    # add devshell module
    inputs.devshell.flakeModule
  ];
}
