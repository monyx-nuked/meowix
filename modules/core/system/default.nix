{ config, ... }:
{
  flake.modules = {
    nixos.system = {
      imports = config.flake.lib.resolve [
        "system.home-manager"
        "system.locale"
        "system.nh"
        "system.nix"
        "system.timezone"
        "system.users"
        "system.git"
      ];
    };
    homeManager.system = {
      imports = config.flake.lib.resolve_hm [
        "system.nix"
        "system.users"
        "system.git"
      ];
    };
  };
}
