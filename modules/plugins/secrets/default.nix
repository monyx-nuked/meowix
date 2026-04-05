{ config, ... }:
{
  flake.modules = {
    nixos.secrets = {
      imports = config.flake.lib.resolve [
        "system.sops"
      ];
    };
    homeManager.secrets = {
      imports = config.flake.lib.resolve_hm [
        "system.sops"
      ];
    };
    darwin.secrets = {
      imports = config.flake.lib.resolve_darwin [
        "system.sops"
      ];
    };
  };
}
