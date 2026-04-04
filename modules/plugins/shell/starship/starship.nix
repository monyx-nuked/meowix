{
  flake.modules.homeManager."shell.starship" = {
    programs.starship =
      { config, lib, ... }:
      {
        enable = true;
        enableTransience = lib.mkIf config.programs.fish.enable true;
        settings = builtins.importTOML ./starship.toml;
      };
  };
}
