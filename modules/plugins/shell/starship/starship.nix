{
  flake.modules.homeManager."shell.starship" =
    { config, lib, ... }:
    {
      programs.starship = {
        enable = true;
        enableTransience = lib.mkIf config.programs.fish.enable true;
      };
    };
}
