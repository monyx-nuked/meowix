{ config, ... }:
{
  flake.modules = {
    nixos."system" = {
      imports = config.flake.lib.resolve [
        "system.home-manager"
        "system.locale"
        "system.nh"
        "system.nix-ld"
        "system.nix"
        "system.nixpkgs"
        "system.timezone"
        "system.users"
        "system.git"
      ];
    };
    homeModules."system" = {
      imports = config.flake.lib.resolve [
        "system.users"
        "system.git"
      ];
    };
  };
}
