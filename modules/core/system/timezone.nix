{
  flake.modules.nixos."system.timezone" =
    { options, ... }:
    {
      time.timeZone = "Asia/Tashkent";
      networking.timeServers = options.networking.timeServers.default ++ [
        "time.nist.gov"
      ];
    };
}
