{ config, ... }:
{
  flake.modules = {
    nixos."system.git" = {
      # Prevent VSCode from exploding when updating
      programs.git = {
        enable = true;
        lfs.enable = true;
        config = [
          {
            init = {
              defaultBranch = "main";
            };
          }
          {
            user = {
              name = config.flake.meta.user.github.username;
              inherit (config.flake.meta.user) email;
              signingKey = "073E3C156F150245";
            };
          }
          {
            commit = {
              gpgSign = true;
            };
            tag = {
              gpgSign = true;
            };
          }
        ];
      };
    };
    homeManager."system.git" = {
      programs.git = {
        enable = true;
        lfs.enable = true;
        settings = {
          init = {
            defaultBranch = "main";
          };
          user = {
            name = config.flake.meta.user.github.username;
            inherit (config.flake.meta.user) email;
          };
        };
      };
    };
  };
}
