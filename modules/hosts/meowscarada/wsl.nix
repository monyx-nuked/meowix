{ config, ... }:
{
  flake.modules.nixos."system.wsl" = {
    wsl = {
      enable = true;
      defaultUser = config.flake.meta.user.username;
      interop = {
        includePath = true;
        register = true;
      };
      ssh-agent.enable = true;
      startMenuLaunchers = true;
      # usbip is not needed unless i have arduino or some sort of stuff
      useWindowsDriver = true;
      wrapBinSh = true;
      wslConf = {
        automount.enabled = true; # Enable because interop needs it
      };
    };
  };
}
