{ lib, inputs, ... }:
let
  user = rec {
    username = "monyx";
    full.name = "m0nyx";
    email = "helix.nuked@proton.me";
    github = {
      username = "monyx-nuked";
      repo = "meowix";
    };
    ssh.authorizedKeys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDKgQ9DA22OYc+x0TOVqzGIXYQQudAdS9WPEe6y8S3VX monyx@meowscarada"
    ];
    gpg = {
      fingerprint = "86D7 F83B 3BCF 74D7 D0C4  752C F15B 6116 3CFC EBDD";
      publicKeyFile = inputs.self + /config/gpg/public_key.asc;
    };
    avatar = {
      # If the source is empty then automatically get from github
      source = null;
      # Get hash from nix-prefetch-url "https://github.com/monyx-nuked.png"
      sha256 = "06x8bdn80ysyk62p6gxldrj6gq9dwm29dbffg3dkzayy1lcl293p";
      # URL Constructed from github.username
      url = "https://github.com/${github.username}.png";
    };
  };

  inherit (lib) mkOption types;

  # Reusable submodule for simple enable flags
  enable_submodule = types.submodule {
    options.enable = mkOption {
      type = types.bool;
      default = false;
      description = "Whether to enable this feature";
    };
  };

  stateversion_module = types.submodule {
    options = {
      nixos = mkOption {
        type = types.nonEmptyStrl;
        default = "25.11";
        description = "State Version of the NixOS";
      };
      home = mkOption {
        type = types.nonEmptyStrl;
        default = "25.11";
        description = "State Version of the home-manager";
      };
      darwin = mkOption {
        type = types.nonEmptyStrl;
        default = "6";
        description = "State Version of the nix-darwin";
      };
    };
  };
in
{
  options.flake.meta = {

    user = mkOption {
      description = "User metadata";
      type = types.submodule {
        options = {
          username = mkOption {
            type = types.nonEmptyStr;
            description = "Primary username";
          };
          full = mkOption {
            type = types.submodule {
              options.name = mkOption {
                type = types.nonEmptyStr;
                description = "Display name";
              };
            };
            description = "Full name info";
          };
          email = mkOption {
            type = types.nonEmptyStr;
            description = "Email address";
          };
          github = mkOption {
            type = types.submodule {
              options = {
                username = mkOption {
                  type = types.nonEmptyStr;
                  description = "GitHub username";
                };
                repo = mkOption {
                  type = types.nonEmptyStr;
                  description = "GitHub repo name";
                };
              };
            };
            description = "GitHub metadata";
          };
          ssh = mkOption {
            type = types.submodule {
              options.authorizedKeys = mkOption {
                type = types.listOf types.str;
                default = [ ];
                description = "List of authorized SSH public keys";
              };
            };
            description = "SSH settings";
          };
          gpg = mkOption {
            type = types.submodule {
              options = {
                fingerprint = mkOption {
                  type = types.nonEmptyStr;
                  description = "GPG key fingerprint";
                };
                publicKeyFile = mkOption {
                  type = types.path;
                  description = "Path to the GPG public key file";
                };
              };
            };
            description = "GPG key info";
          };
          avatar = mkOption {
            type = types.submodule {
              options = {
                source = mkOption {
                  type = types.nullOr types.path;
                  default = null;
                  description = "Local avatar path; if null, fetched from GitHub";
                };
                sha256 = mkOption {
                  type = types.nonEmptyStr;
                  description = "SHA256 Hash of the file";
                };
                url = mkOption {
                  type = types.nonEmptyStr;
                  description = "Remote avatar URL";
                };
              };
            };
            description = "Avatar settings";
          };
        };
      };
    };

    unfree = mkOption {
      type = enable_submodule;
      default = { };
      description = "Unfree toggle";
    };

    hosts = mkOption {
      type = types.listOf (
        types.submodule {
          options = {
            name = mkOption {
              type = types.nonEmptyStr;
              description = "Host name (must match flake id)";
            };
            ssh = mkOption {
              type = types.submodule {
                options.alias = mkOption {
                  type = types.nullOr types.nonEmptyStr;
                  default = null;
                  description = "Short SSH alias for this host";
                };
              };
              default = { };
              description = "SSH settings for this host";
            };
            tailscale = mkOption {
              type = enable_submodule;
              default = { };
              description = "Tailscale settings for this host";
            };
            stateversion = mkOption {
              type = stateversion_module;
              default = { };
              description = "State Version info about this host";
            };
          };
        }
      );
      default = [ ];
      description = "Dashboard of managed hosts";
    };

    nvidia_driver = mkOption {
      type = enable_submodule;
      default = { };
      description = "NVIDIA GPU toggle";
    };

    intel_driver = mkOption {
      type = enable_submodule;
      default = { };
      description = "Intel GPU toggle";
    };

    cuda = mkOption {
      type = enable_submodule;
      default = { };
      description = "CUDA (nixpkgs) toggle";
    };

    extra = mkOption {
      type = types.attrsOf types.anything;
      default = { };
      description = "Free-form extra metadata";
    };
  };

  config.flake.meta = {
    inherit user;
    unfree.enable = lib.mkDefault true;
    nvidia_driver.enable = lib.mkDefault false;
    intel_driver.enable = lib.mkDefault false;
    cuda.enable = lib.mkDefault false;
  };
}
