let
  moduleName = "shell/fish";
in
{
  flake.modules.nixos.${moduleName} =
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
  flake.modules.homeManager.${moduleName} = {
    program.fish.enable = true;
  };
}
