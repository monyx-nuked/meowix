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
    meta.hosts = [ host_meta ];
    modules.nixos."${prefix}${host_name}" = {
      imports = config.flake.lib.resolve [
        "system.nix"
        "system.home-manager"
        "system.users"
        "system.nixpkgs"
        "shell.fish"
        "shell.utils"
        inputs.nixos-wsl.nixosModules.default
      ];
      home-manager.users.${config.flake.meta.user.username} = {
        home.stateVersion = host_meta.stateversion.home;
        imports = config.flake.lib.resolve_hm [
          "system.users"
          "shell.direnv"
          "shell.fish"
          "shell.utils"
        ];
      };
      wsl.enable = true;
      wsl.defaultUser = config.flake.meta.user.username;
      system.stateVersion = host_meta.stateversion.nixos;
      nixpkgs.hostPlatform = "x86_64-linux";
    };
  };
}
