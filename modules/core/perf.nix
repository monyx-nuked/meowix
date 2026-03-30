_:
let
  moduleName = "core/perf";
in
{
  flake.modules.nixos.${moduleName} = {
    boot.tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
  };
}
