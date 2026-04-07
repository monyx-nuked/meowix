{ config, ... }:
{
  flake.modules = {
    nixos.etc = {
      imports = config.flake.lib.resolve [
        "etc.catppuccin"
      ];
    };
    homeManager.etc = {
      imports = config.flake.lib.resolve_hm [
        "etc.catppuccin"
      ];
    };
    darwin.etc = {
      imports = config.flake.lib.resolve_darwin [
        "etc.catppuccin"
      ];
    };
  };
}
