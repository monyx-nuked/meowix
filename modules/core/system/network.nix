{
  flake.modules = {
    nixos."system.network" =
      { config, ... }:
      {
        # Disable wait-online
        systemd.network.wait-online.enable = !config.networking.networkmanager.enable;
        networking = {
          networkmanager = {
            insertNameservers = [
              "1.1.1.1"
              "1.0.0.1"
            ];
            wifi.backend = "iwd";
            dhcp = "internal";
          };
          dhcpcd.enable = !config.networking.networkmanager.enable;
          wireless.iwd = {
            inherit (config.networking.networkmanager) enable;
            settings.Settings.AutoConnect = true;
          };
        };
      };
  };
}
