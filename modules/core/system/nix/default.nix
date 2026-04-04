{ config, ... }:
{
  flake.modules = {
    nixos."system.nix" = {
      imports = config.flake.lib.resolve [
        "system.nix.nix"
        "system.nix.nixpkgs"
        "system.nix.nix-ld"
      ];
    };
    homeManager."system.nix" = {
      imports = config.flake.lib.resolve_hm [
        "system.nix.nixpkgs"
      ];
    };
    darwin."system.nix" = {
      imports = config.flake.lib.resolve_darwin [
        "system.nix.nix"
        "system.nix.nix-ld"
      ];
    };
  };
}
