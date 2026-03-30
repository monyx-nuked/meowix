let
  moduleName = "applications/gemini";
in
{
  flake.modules.homeManager.${moduleName} = {
    programs.gemini-cli.enable = true;
  };
}
