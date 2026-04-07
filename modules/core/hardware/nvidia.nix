{ config, ... }:
let
  flake_config = config;
in
{
  flake.modules.nixos."hardware.nvidia" =
    {
      lib,
      pkgs,
      config,
      ...
    }:
    lib.mkIf flake_config.flake.meta.nvidia_driver.enable {
      users.users.${flake_config.flake.meta.user.username}.extraGroups = [
        "video"
        "render"
      ];
      services.xserver.videoDrivers = [ "nvidia" ];
      hardware = {
        enableRedistributableFirmware = lib.mkForce true;
        graphics = {
          enable = lib.mkDefault true;
          extraPackages = with pkgs; [
            libvdpau-va-gl # For VDPAU-Only apps
          ];
        };
        nvidia = {
          open = true;
          # Configure PRIME Settings in host-specific module
          modesetting.enable = true;
          package = config.boot.kernelPackages.nvidiaPackages.production;
        };
      };
      environment.systemPackages = [
        pkgs.nvtopPackages.full # Install nvtop for both GPU support
      ];
    };
}
