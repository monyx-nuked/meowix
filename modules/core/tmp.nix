_:
let
  moduleName = "core/tmp";
in
{
  flake.modules.nixos.${moduleName} = {
    boot.tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
  };
}
