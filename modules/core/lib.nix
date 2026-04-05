{ config, lib, ... }:
let
  mkResolve =
    modules:
    builtins.concatMap (
      mod:
      if !builtins.isString mod then
        [ mod ]
      else if lib.hasSuffix "?" mod then
        let
          name = lib.removeSuffix "?" mod;
        in
        lib.optional (builtins.hasAttr name modules) modules.${name}
      else
        [ modules.${mod} ]
    );
in
{
  # Helper functions for host path resolving
  # > resolve - resolve module names for NixOS
  # > resolveHm - resolve module names for home-manager
  # > resolveDarwin - resolve module name for Darwin
  config.flake.lib = {
    resolve = mkResolve config.flake.modules.nixos;
    resolve_hm = mkResolve config.flake.modules.homeManager;
    resolve_darwin = mkResolve config.flake.modules.darwin;
  };
}
