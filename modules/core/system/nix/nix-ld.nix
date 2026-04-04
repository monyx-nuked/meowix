{
  flake.modules = {
    nixos."system.nix.nix-ld" = {
      programs.nix-ld = {
        enable = true;
        libraries = [ ];
      };
    };
  };
}
