_: {
  flake.modules = {
    nixos."system.nix-ld" = {
      programs.nix-ld = {
        enable = true;
        libraries = [ ];
      };
    };
  };
}
