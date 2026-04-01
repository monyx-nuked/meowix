let
  moduleName = "shell/direnv";
in
{
  flake.modules.homeManager.${moduleName} = {
    programs.direnv = {
      enable = true;
      silent = true;
      nix-direnv.enable = true;
    };
  };
}
