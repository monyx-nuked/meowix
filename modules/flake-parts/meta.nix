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
in
{
  # Implement a whole custom module for metadata with type-safe validation
  config.flake.meta = {
    user = mkOption {
      type = types.attrs;
      default = { };
    };
  };
  options.flake.meta = {
    inherit user;
  };
}
