{
  inputs,
  lib,
  config,
  ...
}:
let
  prefix = "hosts.";
  platform = {
    nixos = {
      default.system = "x86_64-linux";
      function.system = inputs.nixpkgs.lib.nixosSystem;
      # Get values instead of manually setting each
      modules = builtins.attrValues {
        # Global modules:
        #   Global modules are imported first-class so some options aren't missing
        #   There is possible way to import for each file but it is annoying
        home-manager = inputs.home-manager.nixosModules.home-manager;
        determinate = inputs.determinate.nixosModules.default;
        nur = inputs.nur.modules.nixos.default;
        nix-index = inputs.nix-index-database.nixosModules.default;
        catppuccin = inputs.catppuccin.nixosModules.catppuccin;
      };
    };
    darwin = {
      default.system = "x86_64-darwin";
      function.system = inputs.nix-darwin.lib.darwinSystem;
      # Get values instead of manually setting each
      modules = builtins.attrValues {
        # Global modules:
        #   Global modules are imported first-class so some options aren't missing
        #   There is possible way to import for each file but it is annoying
        home-manager = inputs.home-manager.darwinModules.home-manager;
        nur = inputs.nur.modules.darwin.default;
        nix-index = inputs.nix-index-database.darwinModules.default;
      };
    };
    # Auxiliary
    home-manager = {
      modules = builtins.attrValues {
        # Global modules:
        #   Global modules are imported first-class so some options aren't missing
        #   There is possible way to import for each file but it is annoying
        nur = inputs.nur.modules.homeManager.default;
        nix-index = inputs.nix-index-database.homeModules.default;
        catppuccin = inputs.catppuccin.homeModules.catppuccin;
      };
    };
  };

  host =
    host_type: host_name: host_module:
    let
      name = lib.removePrefix prefix host_name;
      type_platform = platform.${host_type};
      eval_system =
        if (config ? systems) && (config.systems != [ ]) then
          let
            is_darwin = s: lib.hasSuffix "-darwin" s;
            matching_systems = lib.filter (s: (host_type == "darwin") == (is_darwin s)) config.systems;
          in
          if matching_systems != [ ] then builtins.head matching_systems else type_platform.default.system
        else
          type_platform.default.system;
    in
    {
      inherit name;
      value = type_platform.function.system {
        modules = [
          host_module
        ]
        ++ type_platform.modules
        ++ [
          {
            # Global modules
            home-manager.sharedModules = platform.home-manager.modules;
          }
          {
            nixpkgs.hostPlatform = lib.mkDefault eval_system;
          }
        ];
      };
    };

  nixos_modules = lib.filterAttrs (name: value: lib.hasPrefix prefix name) (
    config.flake.modules.nixos or { }
  );
  darwin_modules = lib.filterAttrs (name: value: lib.hasPrefix prefix name) (
    config.flake.modules.darwin or { }
  );
in
{
  flake = {
    nixosConfigurations = lib.mapAttrs' (host "nixos") nixos_modules;
    darwinConfigurations = lib.mapAttrs' (host "darwin") darwin_modules;
  };
}
