{ config, lib, ... }:
{
  # Helper functions for modules
  # > resolveOS - resolve module names for NixOS
  # > resolveHm - resolve module names for home-manager
  # > resolveDarwin - resolve module names for Darwin
  config.flake.lib = {
    resolveOS =
      module:
      builtins.map (if builtins.isString module then config.flake.modules.nixos.${module} else module);
    resolveHm =
      module:
      builtins.map (
        if builtins.isString module then config.flake.modules.homeManager.${module} else module
      );
    resolveDarwin =
      module:
      builtins.map (if builtins.isString module then config.flake.modules.darwin.${module} else module);

    # TODO: Research what is builtins.map and how it works
  };
}
