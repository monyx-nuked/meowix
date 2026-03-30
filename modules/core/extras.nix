_:
let
  moduleName = "core/extras";
in
{
  flake.modules.nixos.${moduleName} = {
    boot.tmp.cleanOnBoot = true;
  };
}
