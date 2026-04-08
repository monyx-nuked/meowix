{ config, ... }:
{
  flake.modules = {
    nixos.dev = {
      imports = config.flake.lib.resolve [
        # Empty as of right now
      ];
    };
    darwin.dev = {
      imports = config.flake.lib.resolve_darwin [
        # Empty as of right now
      ];
    };
    homeManager.dev = {
      imports = config.flake.lib.resolve_hm [
        "dev.direnv"
        "dev.uv"
        "dev.gemini"
      ];
    };
  };
}
