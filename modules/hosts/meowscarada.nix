{ inputs, ... }:
let
  prefix = "hosts.";
  host_name = "meowscarada";
in
{
  flake.modules.nixos."${prefix}${host_name}" = {
  };
}
