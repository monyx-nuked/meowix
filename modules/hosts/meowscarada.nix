{ inputs, config, ... }:
let
  hostMeta = {
    name = "meowscarada";
    system = "x86_64-linux";
    network.ssh.alias = "wsl";
  };
in
{
  flake = {
    meta.hosts = [ hostMeta ];
    modules.nixos."hosts/meowscarada" = {
      imports = config.flake.lib.resolveOS [
        "dummy"
        inputs.nixos-wsl.nixosModules.default
      ];
      wsl.enable = true;
      system.stateVersion = "25.11";
    };
  };
}
