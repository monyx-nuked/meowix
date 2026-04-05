{ inputs, ... }:
{
  flake.modules = {
    nixos."secrets.sops" = _: {
      sops = {
        defaultSopsFile = inputs.self + /secrets/secrets.yaml;
        defaultSopsFormat = "yaml";
        age.keyFile = "/etc/sops-nix/key.txt";
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
  };
}
