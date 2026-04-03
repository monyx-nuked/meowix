{ inputs, config, ... }:
let
  prefix = "hosts.";
  host_name = "meowscarada";
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
      wsl.enable = true;
      system.stateVersion = "25.11";
    };
  };
}
