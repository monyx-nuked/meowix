let
  moduleName = "shell/bat";
in
{
  flake.modules.homeManager.${moduleName} =
    { pkgs, ... }:
    {
      programs.bat.enable = true;

      home.packages = with pkgs; [
        glow # Markdown renderer
      ];
    };
}
