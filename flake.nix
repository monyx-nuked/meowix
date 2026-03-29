{
  description = "A flake for nix(os) configuration";
  # Import all modules from modules directory recursively ( files starting with _ will be ignored )
  # import-tree is altarnative to haumea but it is easier to use
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
  inputs = {
    # Flake-Parts: framework for writing flakes
    flake-parts.url = "https://flakehub.com/f/hercules-ci/flake-parts/*";
    # Import-tree: recursively import nix files from a directory
    import-tree.url = "github:vic/import-tree";
    # Nixpkgs: biggest repository in the distro-world
    # Version: latest unstable version, 0.1 means unstable
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
  };
}
