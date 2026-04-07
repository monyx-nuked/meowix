{ config, ... }:
{
  flake.modules = {
    nixos.hardware = {
      imports = config.flake.lib.resolve [
        "hardware.nvidia"
        "hardware.intel"
      ];
    };
    homeManager.hardware = {
      imports = config.flake.lib.resolve_hm [

      ];
    };
    darwin.hardware = {
      imports = config.flake.lib.resolve_darwin [

      ];
    };
  };
}
