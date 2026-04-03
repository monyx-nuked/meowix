_: {
  flake.modules.nixos."shell.fish" =
    { pkgs, ... }:
    {
      programs.fish = {
        enable = true;
        useBabelfish = true;
      };
      environment.shells = with pkgs; [
        fish
        dash
      ];
    };
  flake.modules.homeManager."shell.fish" =
    { pkgs, lib, ... }:
    {
      programs = {
        fish.enable = true;
        starship.enable = lib.mkDefault true;
      };
    };
}
