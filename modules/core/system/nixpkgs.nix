{ config, ... }:
let
  inherit (config.flake.meta) unfree cuda;
in
{
  flake.modules = {
    nixos."system.nixpkgs" = {
      nixpkgs.config = {
        allowUnfree = unfree.enable;
        cudaSupport = cuda.enable;
        cudaForwardCompat = cuda.enable;
      };
    };
    darwin."system.nixpkgs" = {
      nixpkgs.config.allowUnfree = unfree.enable;
    };
  };
}
