{
  inputs,
  lib,
  config,
  ...
}:
let
  prefix = "hosts/";
  defPlatform = {
    nixos = {
      defsystem = "x86_64-linux";
      builder = inputs.nixpkgs.lib.nixosSystem;
      hmModule = inputs.home-manager.nixosModules.home-manager;
      # Enable determinate package manager for nixos only
      # as x86_64-darwin for determinate is deprecated
      determinate = inputs.determinate.nixosModules.default;
    };
    darwin = {
      defsystem = "x86_64-darwin";
      builder = inputs.nix-darwin.lib.darwinSystem;
      hmModule = inputs.home-manager.darwinModules.home-manager;
      determinate = { };
    };
  };

  mkHost =
    htype: name: hmodule:
    let
      id = lib.removePrefix prefix name;
      platform = defPlatform.${htype};

      evalSystem =
        if (config ? system) && (config.systems != [ ]) then
          let
            isDarwin = sys: lib.hasSuffix "-darwin" sys;
            mSystems = lib.filter (sys: (htype == "darwin") == (isDarwin sys)) config.systems;
          in
          if mSystems != [ ] then builtins.head mSystems else platform.defsystem
        else
          platform.defsystem;
    in
    {
      name = id;
      value = platform.builder {
        modules = [
          # The host module
          hmodule
          # Import home-manager module specified for the platform
          platform.hmModule
          platform.determinate
          {
            home-manager = {
              # Bare bones home-manager settings
              useGlobalPkgs = true;
              useUserPackages = true;
            };
          }
          {
            nixpkgs.hostPlatform = lib.mkDefault evalSystem;
          }
        ];
      };
    };

  # Filter the modules with host prefix and return attrset
  # or in more specific way map those with name | value
  nixosModules = lib.filterAttrs (name: _: lib.hasPrefix prefix name) (
    config.flake.modules.nixos or { }
  );
  darwinModules = lib.filterAttrs (name: _: lib.hasPrefix prefix name) (
    config.flake.modules.darwin or { }
  );
in
{
  flake = {
    # This curries the mkHost function for each platform and then
    # TODO: Research what's difference between mapAttrs and mapAttrs' and explore them both
    nixosConfigurations = lib.mapAttrs' (mkHost "nixos") nixosModules;
    darwinConfigurations = lib.mapAttrs' (mkHost "darwin") darwinModules;
  };
}
