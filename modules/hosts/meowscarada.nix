{ inputs, config, ... }:
let
  prefix = "hosts.";
  host_name = "meowscarada";
  global_stateversion = "25.11";
  host_meta = {
    name = host_name;
    ssh.alias = "wsl";
    tailscale.enable = false;
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
        inputs.nixos-wsl.nixosModules.default
      ];
      home-manager.users.${config.flake.meta.user.username} = {
        home.stateVersion = global_stateversion;
        imports = config.flake.lib.resolveHm [
          "system.users"
        ];
      };
      wsl.enable = true;
      wsl.defaultUser = config.flake.meta.user.username;
      system.stateVersion = global_stateversion;
    };
  };
}
