{ config, ... }:
{
  flake.modules = {
    nixos.secrets = {
      imports = config.flake.lib.resolve [
        "secrets.sops"
      ];
    };
    homeManager.secrets = {
      imports = config.flake.lib.resolve_hm [
        "secrets.sops"
      ];
    };
    darwin.secrets = {
      imports = config.flake.lib.resolve_darwin [
        "secrets.sops"
      ];
    };
  };
}
