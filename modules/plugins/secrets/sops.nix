{ inputs, ... }:
let
  key_file = "${inputs.self}/secrets/key.txt";
in
{
  flake.modules = {
    nixos."secrets.sops" = {
      sops = {
        defaultSopsFile = "${inputs.self}/secrets/secrets.yaml"; # TODO: Implement for each platform with different values ( if possible )
        defaultSopsFormat = "yaml";
        age.keyFile = key_file;
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
        defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
        defaultSopsFormat = "yaml";
        age.keyFile = key_file;
        secrets = {
          # TODO: Add something
        };
      };
    };
    homeManager."secrets.sops" = {
      sops = {
        defaultSopsFile = "${inputs.self}/secrets/secrets.yaml";
        defaultSopsFormat = "yaml";
        age.keyFile = key_file;
        secrets = {
          # TODO: Add something
        };
      };
    };
  };
}
