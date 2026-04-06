{ inputs, ... }:
let
  key_file = "/var/lib/sops-nix/key.txt";
in
{
  flake.modules = {
    nixos."secrets.sops" =
      # { config, ... }:
      # let
      # nixos_config = config;
      # in
      {
        sops = {
          defaultSopsFile = inputs.self + /secrets/secrets.yaml; # TODO: Implement for each platform with different values ( if possible )
          defaultSopsFormat = "yaml";
          age = {
            keyFile = key_file;
            generateKey = true;
          };
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
    darwin."secrets.sops" =
      # { config, ... }:
      # let
      # darwin_config = config;
      # in
      {
        sops = {
          defaultSopsFile = inputs.self + /secrets/secrets.yaml;
          defaultSopsFormat = "yaml";
          age = {
            keyFile = key_file;
            generateKey = true;
          };
          secrets = {
            # TODO: Add something
          };
        };
      };
    homeManager."secrets.sops" =
      { config, ... }:
      let
        hm_config = config;
      in
      {
        sops = {
          defaultSopsFile = inputs.self + /secrets/secrets.yaml;
          defaultSopsFormat = "yaml";
          age = {
            keyFile = "${hm_config.home.homeDirectory}/.config/sops/age/key.txt";
            generateKey = true;
          };
          secrets = {
            # TODO: Add something
          };
        };
      };
  };
}
