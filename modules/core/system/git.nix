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
              defaultBranch = "master";
            };
          }
          {
            user = {
              name = config.flake.meta.user.github.username;
              email = config.flake.meta.user.email;
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
            defaultBranch = "master";
          };
          user = {
            name = config.flake.meta.user.github.username;
            email = config.flake.meta.user.email;
          };
        };
      };
    };
  };
}
