{
  flake.modules = {
    nixos."system.printing" =
      { pkgs, ... }:
      {
        services = {
          printing = {
            enable = true;
            drivers = [
              pkgs.gutenprint
              pkgs.gutenprintBin
              pkgs.epson-escpr2
            ];
          };
          avahi = {
            enable = true;
            nssmdns4 = true;
            openFirewall = true;
          };
        };
      };
  };
}
