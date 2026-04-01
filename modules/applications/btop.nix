let
  moduleName = "applications/btop";
in
{
  flake.modules.homeManager.${moduleName} = {
    programs.btop.enable = true;
  };
}
