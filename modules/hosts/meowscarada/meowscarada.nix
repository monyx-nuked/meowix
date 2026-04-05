{ inputs, config, ... }:
let
  prefix = "hosts.";
  host_name = "meowscarada";
  host_meta = {
    name = host_name;
    ssh.alias = "wsl";
    tailscale.enable = false;
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
    };
    modules.nixos."${prefix}${host_name}" = {
      imports = config.flake.lib.resolve [
        "system"
        "system.wsl"
        "shell"
        "catppuccin"
        "secrets.sops"
        inputs.nixos-wsl.nixosModules.default
      ];
      home-manager.users.${config.flake.meta.user.username} = {
        home.stateVersion = host_meta.stateversion.home;
        imports = config.flake.lib.resolve_hm [
          "system"
          "dev"
          "shell"
          "catppuccin"
        ];
      };
      networking.hostName = host_name;
      system.stateVersion = host_meta.stateversion.nixos;
      nixpkgs.hostPlatform = "x86_64-linux";
    };
  };
}
