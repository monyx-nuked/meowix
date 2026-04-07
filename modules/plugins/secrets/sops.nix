{ inputs, ... }:
let
  # flake_config = config;
  key_file = "/var/lib/sops-nix/key.txt";
  # user = flake_config.flake.meta.user.username;
in
{
  flake.modules = {
    nixos."secrets.sops" =
      # { config, ... }:
      # let
      #   nixos_config = config;
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
            # Add something
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
            ssh_private = {
              path = "${hm_config.home.homeDirectory}/.ssh/id_ed25519";
              mode = "0600";
            };
            ssh_public = {
              path = "${hm_config.home.homeDirectory}/.ssh/id_ed25519.pub";
              mode = "0600";
            };
          };
        };
      };
  };
}
