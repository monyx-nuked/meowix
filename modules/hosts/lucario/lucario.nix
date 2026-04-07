{ config, ... }:
let
  prefix = "hosts.";
  host_name = "lucario";
  host_meta = {
    name = host_name;
    ssh.alias = "main";
    tailscale.enable = true;
    stateversion = {
      nixos = "25.11";
      home = "25.11";
    };
  };
in
{
  flake = {
    meta = {
      hosts = [ host_meta ];
      unfree.enable = true;
      cuda.enable = true;
      intel_driver.enable = true;
      nvidia_driver.enable = true;
    };
    modules.nixos."${prefix}${host_name}" = {
      imports = config.flake.lib.resolve [
        "system.minimum"
        "system.boot"
        "system.network"
        "system.tty"
        "shell"
        "secrets"
        "etc"
      ];
      home-manager.users.${config.flake.meta.user.username} = {
        home.stateVersion = host_meta.stateversion.home;
        imports = config.flake.lib.resolve_hm [
          "system.minimum"
          "dev"
          "shell"
          "secrets"
          "etc"
        ];
      };
      boot.loader.systemd-boot.enable = true;
      networking = {
        hostName = host_name;
        networkmanager.enable = true;
      };
      system.stateVersion = host_meta.stateversion.nixos;
      nixpkgs.hostPlatform = "x86_64-linux";
    };
  };
}
