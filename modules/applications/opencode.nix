let
  moduleName = "applications/opencode";
in
{
  flake.modules.homeManager.${moduleName} = {
    programs.opencode = {
      enable = true;
      enableMcpIntegration = true;
    };
  };
}
