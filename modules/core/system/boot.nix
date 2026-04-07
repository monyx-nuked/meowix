{
  flake.modules = {
    nixos."system.boot" = {
      boot = {
        initrd.systemd.enable = true;
        loader = {
          efi.canTouchEfiVariables = true;
          systemd-boot = {
            editor = false;
            consoleMode = "max";
          };
        };
      };
    };
  };
}
