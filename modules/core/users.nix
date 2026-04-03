{ config, ... }:
{
  flake.modules = {
    nixos."core.users" =
      { lib, pkgs, ... }:
      {
        users = {
          mutableUsers = true; # TODO: Soon disable this
          users = {
            ${config.flake.meta.user.username} = {
              isNormalUser = true;
              description = config.flake.meta.user.full.name;
              openssh.authorizedKeys.keys = config.flake.meta.user.ssh.authorizedKeys;
              extraGroups = [
                "wheel"
                "networkmanager"
              ];
            };
          };
        };
      };
    home-manager."core.users" =
      { pkgs, ... }:
      let
        inherit (config.flake.meta.user) avatar;
        avatar_file =
          if avatar.source != null then avatar.source else pkgs.fetchUrl { inherit (avatar) url sha256; };
      in
      {
        programs.home-manager.enable = true;
        home = {
          file.".face".source = avatar_file;
        };
      };
  };
}
