{ config, ... }:
{
  # Helper functions for modules
  # > resolveOS - resolve module names for NixOS
  # > resolveHm - resolve module names for home-manager
  # > resolveDarwin - resolve module names for Darwin
  config.flake.lib = {
    resolveOS = builtins.map (
      module: if builtins.isString module then config.flake.modules.nixos.${module} else module
    );
    resolveHm = builtins.map (
      module: if builtins.isString module then config.flake.modules.homeManager.${module} else module
    );
    resolveDarwin = builtins.map (
      module: if builtins.isString module then config.flake.modules.darwin.${module} else module
    );

    # TODO: Research what is builtins.map and how it works
  };
}
