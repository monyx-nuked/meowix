{
  flake.modules.nixos."system.timezone" =
    { options, ... }:
    {
      time.timeZone = "Asia/Tashkent";
      # TODO: Add darwin too
      networking.timeServers = options.networking.timeServers.default ++ [
        "time.nist.gov"
      ];
    };
}
