{
  description = "A flake for nix(os) configuration";
  # Import all modules from modules directory recursively ( files starting with _ will be ignored )
  # import-tree is altarnative to haumea but it is easier to use
  outputs = inputs: inputs.flake-parts.lib.mkFlake { inherit inputs; } (inputs.import-tree ./modules);
  inputs = {
    # Flake-Parts: framework for writing flakes
    flake-parts = {
      url = "https://flakehub.com/f/hercules-ci/flake-parts/*";
      inputs.nixpkgs-lib.follows = "nixpkgs-lib"; # Pin and deduplicate nixpkgs-lib
    };
    # Import-tree: recursively import nix files from a directory
    import-tree.url = "github:vic/import-tree";
    # devshells: better version of devShells
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # home-manager: manage user configuration with nix
    # version: latest stable version, 0.1 means unstable
    home-manager = {
      url = "https://flakehub.com/f/nix-community/home-manager/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # nix-darwin: manage macos configuration with nix
    # version: latest stable version, 0.1 means unstable
    nix-darwin = {
      url = "https://flakehub.com/f/nix-darwin/nix-darwin/0.1";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # determinate: better nix package manager
    determinate.url = "https://flakehub.com/f/DeterminateSystems/determinate/*";
    # git-hooks: pre-commit hooks for nix
    git-hooks = {
      url = "https://flakehub.com/f/cachix/git-hooks.nix/*";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # Nixpkgs: biggest repository in the distro-world
    # Version: latest unstable version, 0.1 means unstable
    nixpkgs.url = "https://flakehub.com/f/NixOS/nixpkgs/0.1";
    # nixpkgs.lib: lib from nixpkgs
    nixpkgs-lib.url = "github:nix-community/nixpkgs.lib";
  };
  nixConfig = {
    extra-trusted-public-keys = [
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    ];
    extra-substituters = [
      "https://install.determinate.systems"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://cachix.cachix.org"
    ];
  };
}
