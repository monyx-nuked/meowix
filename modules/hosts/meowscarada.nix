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
    modules = {
      nixos."hosts/${hostMeta.name}" = {
        imports = config.flake.lib.resolveOS [
          "users"
          "core/core"
          "core/i18n"
          "core/nh"
          "core/timezone"
          "core/perf"
          inputs.nixos-wsl.nixosModules.default
          inputs.catppuccin.nixosModules.catppuccin # Try catppuccin for myself and temporary not enable as a core
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
            inputs.catppuccin.homeManagerModules.catppuccin # Try catppuccin for myself and temporary not enable as a core
          ];
          catppuccin = {
            accent = "sapphire";
            enable = true;
          };
        };
        catppuccin = {
          accent = "sapphire";
          enable = true;
        };
        wsl.enable = true;
        wsl.defaultUser = config.flake.meta.user.username;
        networking.hostName = hostMeta.name;
        system.stateVersion = "25.11";
      };
    };
  };
}
