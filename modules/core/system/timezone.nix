{ lib, ... }:
let
  base_config = {
    time.timeZone = "Asia/Tashkent";
  };
in
{
  flake.modules = {
    nixos."system.timezone" =
      { options, ... }:
      lib.mkMerge [
        base_config
        {
          networking.timeServers = options.networking.timeServers.default ++ [
            "time.nist.gov"
          ];
        }
      ];
    darwin."system.timezone" = base_config;
  };
}
