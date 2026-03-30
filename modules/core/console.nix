let
  moduleName = "core/console";
in
{
  flake.modules.nixos.${moduleName} =
    { pkgs, ... }:
    {
      console = {
        earlySetup = true;
        font = "Lat2-Terminus16";
        packages = with pkgs; [ terminus_font ];
      };
    };
}
