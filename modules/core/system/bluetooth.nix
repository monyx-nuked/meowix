{
  flake.modules = {
    nixos."system.bluetooth" = {
      hardware.bluetooth = {
        enable = true;
        settings = {
          General = {
            Experimental = true;
          };
        };
      };
      services = {
        blueman.enable = true;
        mpris-proxy.enable = true;
      };
    };
    homeManager."system.bluetooth" =
      { lib, ... }:
      {
        services.bluetuith.enable = lib.mkDefault true;
      };
  };
}
