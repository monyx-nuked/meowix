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
        "users"
        "core/core"
        "core/i18n"
        "core/nh"
        "core/timezone"
        "core/extras"
        inputs.nixos-wsl.nixosModules.default
      ];
      # Home Manager configuration for user
      home-manager.users.${config.flake.meta.user.username} = {
        home.stateVersion = "25.11";

        # Home Manager modules (cross-platform)
        imports = config.flake.lib.resolveHm [
          # Home Manager preset modules
          "users"
          "applications/direnv"
          "applications/gemini"
          inputs.nix-index-database.homeModules.default
        ];
      };
      wsl.enable = true;
      wsl.defaultUser = config.flake.meta.user.username;
      networking.hostName = hostMeta.name;
      system.stateVersion = "25.11";
    };
  };
}
