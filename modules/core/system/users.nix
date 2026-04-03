{ config, ... }:
{
  flake.modules = {
    nixos."system.users" =
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
              shell = pkgs.fish;
            };
          };
        };
      };
    homeManager."system.users" =
      { pkgs, ... }:
      let
        inherit (config.flake.meta.user) avatar;
        avatar_file =
          if avatar.source != null then avatar.source else pkgs.fetchurl { inherit (avatar) url sha256; };
      in
      {
        programs.home-manager.enable = true;
        home = {
          inherit (config.flake.meta.user) username;
          homeDirectory =
            if pkgs.stdenv.isDarwin then
              "/Users/${config.flake.meta.user.username}"
            else
              "/home/${config.flake.meta.user.username}";
          file.".face".source = avatar_file;
        };
      };
  };
}
