{ inputs, config, ... }:
let
  moduleName = "users";
in
{
  flake.modules = {
    nixos.${moduleName} =
      { lib, ... }:
      {
        users.users.${config.flake.meta.user.username} = {
          isNormalUser = lib.mkForce true;
          description = lib.mkForce config.flake.meta.user.fullName;
          openssh.authorizedKeys.keys = config.flake.meta.user.ssh.sshPublicKeys;
          extraGroups = [
            "wheel"
            "networkmanager"
          ];
        };
      };
    homeManager.${moduleName} =
      { pkgs, lib, ... }:
      let
        inherit (config.flake.meta.user) avatar;
        avatarFile =
          if avatar.source != null then
            avatar.source
          else
            pkgs.fetchurl {
              inherit (avatar) url sha256;
            };
      in
      {
        programs.home-manager.enable = true;
        home = {
          inherit (config.flake.meta.user) username;
          homeDirectory = lib.mkDefault "/home/${config.flake.meta.user.username}";
          stateVersion = "25.11";
          # Add nix-index-database to homeManager
          imports = [
            inputs.nix-index-database.homeModules.default
          ];
          # Link avatar to .face for display managers
          file.".face".source = avatarFile;
        };
      };
  };
}
