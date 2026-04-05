{ config, ... }:
{
  flake.modules = {
    nixos.shell = {
      imports = config.flake.lib.resolve [
        "shell.fish"
      ];
    };
    darwin.shell = {
      imports = config.flake.lib.resolve_darwin [
        "shell.fish"
      ];
    };
    homeManager.shell = {
      imports = config.flake.lib.resolve_hm [
        "shell.fish"
        "shell.utils?"
      ];
    };
  };
}
