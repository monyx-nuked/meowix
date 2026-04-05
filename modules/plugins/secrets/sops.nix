{ inputs, ... }:
{
  flake.modules = {
    nixos."secrets.sops" = {
      sops = {
        defaultSopsFile = inputs.self + /secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = inputs.self + /secrets/key.txt;
        secrets = {
          user_password = {
            mode = "0400";
            neededForUsers = true;
          };
          root_password = {
            mode = "0400";
            neededForUsers = true;
          };
        };
      };
    };
    darwin."secrets.sops" = {
      sops = {
        defaultSopsFile = inputs.self + /secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = inputs.self + /secrets/key.txt;
        secrets = {
          # TODO: Add something
        };
      };
    };
    homeManager."secrets.sops" = {
      sops = {
        defaultSopsFile = inputs.self + /secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = inputs.self + /secrets/key.txt;
        secrets = {
          # TODO: Add something
        };
      };
    };
  };
}
