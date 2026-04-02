{ inputs, ... }:
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
      system.stateVersion = "25.11";
    };
  };
}
