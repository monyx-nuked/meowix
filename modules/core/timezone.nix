let
  moduleName = "core/timezone";
in
{
  flake.modules.nixos.${moduleName} =
    { options, ... }:
    {
      time.timeZone = "Asia/Tashkent";
      networking.timeServers = options.networking.timeServers.default ++ [
        "time.nist.gov"
      ];
    };
}
