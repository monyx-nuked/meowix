{ lib, ... }:
let
  home-manager = {
    # Base home-manager settings
    # Nixpkgs for home-manager config already exists
    useGlobalPkgs = lib.mkDefault false;
    useUserPackages = lib.mkDefault true;
    # Additional settings for home-manager
    backupFileExtension = "hm-bak";
    overwriteBackup = true;
  };
in
{
  flake.modules = {
    nixos."system.home-manager" = {
      inherit home-manager;
    };
    darwin."system.home-manager" = {
      inherit home-manager;
    };
  };
}
