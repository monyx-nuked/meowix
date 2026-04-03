_: {
  flake.modules.nixos."perf.tmp" = {
    boot.tmp = {
      useTmpfs = true;
      cleanOnBoot = true;
    };
  };
}
