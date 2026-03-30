let
  moduleName = "core/timezone";
in
{
  flake.modules.nixos.${moduleName} = {
    time.timeZone = "Asia/Tashkent";
  };
}
