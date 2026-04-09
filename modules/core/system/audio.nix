{
  flake.modules = {
    nixos."system.audio" =
      { lib, pkgs, ... }:
      {
        security.rtkit.enable = lib.mkDefault true;
        services.pipewire = {
          enable = true; # if not already enabled
          alsa.enable = true;
          alsa.support32Bit = true;
          pulse.enable = true;
          # If you want to use JACK applications, uncomment the following
          #jack.enable = true;
          wireplumber.enable = true;
        };
        environment.systemPackages = [
          pkgs.pwvucontrol
        ];
      };
  };
}
