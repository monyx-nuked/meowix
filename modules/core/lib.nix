{ config, ... }:
{
  # Helper functions for host path resolving
  # > resolve - resolve module names for NixOS
  # > resolveHm - resolve module names for home-manager
  # > resolveDarwin - resolve module name for Darwin
  config.flake.lib = {
    resolve = builtins.map (
      mod: if builtins.isString mod then config.flake.modules.nixos.${mod} else mod
    );
    resolve_hm = builtins.map (
      mod: if builtins.isString mod then config.flake.modules.homeManager.${mod} else mod
    );
    resolve_darwin = builtins.map (
      mod: if builtins.isString mod then config.flake.modules.darwin.${mod} else mod
    );
  };
}
