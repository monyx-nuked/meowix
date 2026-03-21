{ inputs, ... }:
{
  imports = [
    # https://flake.parts/options/flake-parts-modules.html
    # host modules for any module system application.
    inputs.flake-parts.flakeModules.modules
  ];
}
