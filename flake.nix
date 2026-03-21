{
  description = ''
    meowix - nixos configuration w/
        flake-parts and dendritic pattern'';
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
  inputs = {
    # >> BASE <<
    # nixpkgs - latest unstable version
    nixpkgs.url = "https://flakehub.com/f/nixos/nixpkgs/0.1";
    # flake-parts - flake framework
    flake-parts = {
      url = "https://flakehub.com/f/hercules-ci/flake-parts/*";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib";
    };
    # import-tree - recursively import from directory
    import-tree.url = "github:vic/import-tree";
    # nixpkgs-lib - nixpkgs library
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
    # nur - nix user repository
    nur = {
      url = "github:nix-community/nur";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.flake-parts.follows = "flake-parts";
    };
  };
}
