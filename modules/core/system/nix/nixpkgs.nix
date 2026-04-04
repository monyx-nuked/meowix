{ config, lib, ... }:
let
  inherit (config.flake.meta) unfree cuda;
  base_config = {
    nixpkgs.config.allowUnfree = unfree.enable;
  };
  cuda_config = lib.mkMerge [
    base_config
    {
      nixpkgs.config = {
        cudaSupport = cuda.enable;
        cudaForwardCompat = cuda.enable;
      };
    }
  ];
in
{
  flake.modules = {
    nixos."system.nix.nixpkgs" = cuda_config;
    homeManager."system.nix.nixpkgs" = cuda_config;
    darwin."system.nix.nixpkgs" = base_config;
  };
}
