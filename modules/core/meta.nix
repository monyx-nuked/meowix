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
    ssh.authorizedKeys = [ "" ];
    gpg = {
      fingerprint = "BB64 31B5 B087 C4F3 29F8 857C 2F17 ABD4 5C0F FD95";
      publicKeyFile = inputs.self + /config/gpg;
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
      # keyed by package name or category, each togglable
      type = enable_submodule;
      default = { };
      description = "Per-package unfree toggles";
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
          };
        }
      );
      default = [ ];
      description = "Dashboard of managed hosts";
    };

    extra = mkOption {
      type = types.attrsOf types.anything;
      default = { };
      description = "Free-form extra metadata";
    };
  };

  config.flake.meta = {
    inherit user;
    unfree.enable = true;
  };
}
