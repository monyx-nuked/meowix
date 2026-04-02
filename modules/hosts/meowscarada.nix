{ inputs, ... }:
let
  prefix = "hosts.";
  host_name = "meowscarada";
in
{
  flake.modules.nixos."${prefix}${host_name}" = {
    system.stateVersion = "25.11";
  };
}
