_: {
  flake.modules = {
    nixos."core.nix-ld" = {
      programs.nix-ld.enable = true;
    };
  };
}
