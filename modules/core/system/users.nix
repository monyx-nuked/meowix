{ config, ... }:
let
  top_config = config;
in
{
  flake.modules = {
    nixos."system.users" =
      {
        lib,
        pkgs,
        config,
        ...
      }:
      {
        users = {
          mutableUsers = true; # TODO: Soon disable this
          users = {
            root = {
              isSystemUser = true;
              initialPassword = "meowix";
              hashedPasswordFile = config.sops.secrets."user_password".path;
            };
            ${top_config.flake.meta.user.username} = {
              initialPassword = "meowix";
              hashedPasswordFile = config.sops.secrets."user_password".path;
              isNormalUser = true;
              description = top_config.flake.meta.user.full.name;
              openssh.authorizedKeys.keys = top_config.flake.meta.user.ssh.authorizedKeys;
              shell = lib.mkIf config.programs.fish.enable pkgs.fish;
              extraGroups = [
                "wheel"
                "networkmanager"
              ];
            };
          };
        };
      };
    darwin."system.users" =
      {
        config,
        lib,
        pkgs,
        ...
      }:
      {
        users = {
          ${top_config.flake.meta.user.username} = {
            description = top_config.flake.meta.user.full.name;
            openssh.authorizedKeys.keys = top_config.flake.meta.user.ssh.authorizedKeys;
            shell = lib.mkIf config.programs.fish.enable pkgs.fish;
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
