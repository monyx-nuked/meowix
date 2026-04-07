{ config, ... }:
{
  flake.modules.nixos."hardware.intel" =
    {
      lib,
      pkgs,
      ...
    }:
    lib.mkIf config.flake.meta.intel_driver.enable {
      users.users.${config.flake.meta.user.username}.extraGroups = [
        "video"
        "render"
      ];
      services.xserver.videoDrivers = [ "modesetting" ];
      hardware = {
        enableRedistributableFirmware = lib.mkForce true;
        graphics = {
          enable = lib.mkDefault true;
          extraPackages = [
            # Specify in host for standard configuration
            # pkgs.intel-media-driver # VA-API (iHD) userspace
            # pkgs.intel-media-sdk # oneVPL (QSV) runtime
            pkgs.libvdpau-va-gl # For VDPAU-Only apps
          ];
        };
      };
      environment.systemPackages = [
        pkgs.nvtopPackages.full # Install nvtop for both GPU support
        pkgs.intel-gpu-tools # Intel iGPU accurate meter
      ];
      boot.kernelParams = [ "i915.enable_guc=3" ];
      environment.sessionVariables = {
        LIBVA_DRIVER_NAME = "iHD"; # Prefer the modern iHD backend
      };
    };
}
