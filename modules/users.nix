{ config, ... }:
let
  moduleName = "users";
in
{
  flake.modules = {
    nixos.${moduleName} = {
      users.users.${config.flake.meta.user.username} = {
        isNormalUser = true;
        description = config.flake.meta.user.fullName;
        openssh.authorizedKeys.keys = config.flake.meta.user.ssh.sshPublicKeys;
        extraGroups = [
          "wheel"
          "networkmanager"
        ];
      };
    };
    homeManager.${moduleName} =
      { pkgs, ... }:
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
          homeDirectory = "/home/${config.flake.meta.user.username}";
          stateVersion = "25.11";

          # Link avatar to .face for display managers
          file.".face".source = avatarFile;
        };
      };
  };
}
