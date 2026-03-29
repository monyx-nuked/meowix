{ lib, ... }:
let
  user = rec {
    username = "monyx";
    fullName = "m0nyx";
    email = "helx.nuked@proton.me";
    github = {
      username = "monyx-nuked";
      repo = "meowix";
    };
    gpg = {
      # TODO: Add gpg fingerprint and public key
      fingerprint = "";
      publicKeyFile = "";
    };
    ssh = {
      authorizedKeysFile = [
        # TODO: Add ssh authorized keys here
        ""
      ];
    };
    avatar = {
      # Path to custom avatar, if null then fetch from github
      source = null;
      # SHA256 hash of the avatar image
      sha256 = "06x8bdn80ysyk62p6gxldrj6gq9dwm29dbffg3dkzayy1lcl293p";
      # use nix-prefetch-url to fetch the avatar from github
      url = "https://github.com/${github.username}.png";
    };
  };
  inherit (lib) mkOption types;

  githubSubmodule = types.submodule {
    options = {
      username = mkOption {
        type = types.nonEmptyStr;
        description = "GitHub username.";
      };
      repo = mkOption {
        type = types.nonEmptyStr;
        description = "Primary GitHub repository name";
      };
    };
  };

  gpgSubmodule = types.submodule {
    options = {
      fingerprint = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "GPG key fingerprint.";
      };
      publicKeyFile = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Path to the GPG public key file";
      };
    };
  };

  sshUserSubmodule = types.submodule {
    options = {
      authorizedKeysFile = mkOption {
        type = types.listOf types.str;
        default = [ ];
        description = "List of authorized SSH public keys";
      };
    };
  };

  sshHostSubmodule = types.submodule {
    options = {
      alias = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "SSH alias for this host.";
      };
      publicKey = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "SSH public key of the host.";
      };
    };
  };

  avatarSubmodule = types.submodule {
    options = {
      source = mkOption {
        type = types.nullOr types.path;
        default = null;
        description = "Path to a local avatar image. If null, fetched from GitHub";
      };
      sha256 = mkOption {
        type = types.str;
        description = "SHA256 hash of the avatar image";
      };
      url = mkOption {
        type = types.str;
        description = "URL to fetch the avatar from if source is null";
      };
    };
  };

  userSubmodule = types.submodule {
    options = {
      username = mkOption {
        type = types.nonEmptyStr;
        description = "System username";
      };
      fullName = mkOption {
        type = types.str;
        default = "";
        description = "Display name of the user";
      };
      email = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "User email address";
      };
      github = mkOption {
        type = githubSubmodule;
        description = "GitHub account metadata";
      };
      gpg = mkOption {
        type = gpgSubmodule;
        default = { };
        description = "GPG key metadata";
      };
      ssh = mkOption {
        type = sshUserSubmodule;
        default = { };
        description = "SSH configuration";
      };
      avatar = mkOption {
        type = avatarSubmodule;
        description = "Avatar image configuration";
      };
    };
  };

  networkSubmodule = types.submodule {
    options = {
      ip = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "Host IP address";
      };
      ssh = mkOption {
        type = sshHostSubmodule;
        default = { };
        description = "SSH network metadata";
      };
    };
  };

  hostSubmodule = types.submodule {
    options = {
      name = mkOption {
        type = types.nonEmptyStr;
        description = "Hostname of the machine (should match flake id)";
      };
      system = mkOption {
        type = types.nonEmptyStr;
        description = "Nix system string (e.g. x86_64-linux)";
      };
      network = mkOption {
        type = networkSubmodule;
        default = { };
        description = "Network metadata. Fully optional";
      };
    };
  };

  dotfilesSubmodule = types.submodule {
    options = {
      url = mkOption {
        type = types.nonEmptyStr;
        description = "URL of the dotfiles repository";
      };
    };
  };
in
{
  # TODO: Implement a whole custom module for metadata with type-safe validation
  options.flake.meta = {
    user = mkOption {
      type = userSubmodule;
      description = "User metadata";
    };
    dotfiles = mkOption {
      type = dotfilesSubmodule;
      description = "Dotfiles repository metadata";
    };
    hosts = mkOption {
      type = types.listOf hostSubmodule;
      default = [ ];
      description = "List of hosts in this flake";
    };
    unfree = mkOption {
      type = types.bool;
      default = true;
      description = "Whether this flake contains unfree software";
    };
    extra = mkOption {
      type = types.attrs;
      default = { };
      description = "Extra metadata for this flake";
    };
  };
  config.flake.meta = {
    inherit user;

    dotfiles = {
      url = "https://github.com/${user.github.username}/dotfiles";
    };

    unfree = true;
  };
}
