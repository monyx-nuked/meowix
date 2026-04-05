{ config, ... }:
{
  flake.modules = {
    nixos."system.gpg" =
      { pkgs, ... }:
      {
        # NixOS-specific GPG Agent configuration
        programs.gnupg.agent = {
          enable = true;
          enableSSHSupport = true;
          # CRITICAL for WSL: Shows the password prompt in the terminal
          pinentryPackage = pkgs.pinentry-curses;
        };
      };
    homeManager."system.gpg" = {
      programs.gpg = {
        enable = true;
        publicKeys = [
          {
            source = config.flake.meta.user.gpg.publicKeyFile;
            trust = "ultimate";
          }
        ];
      };
    };
    darwin."system.gpg" = {
      # nix-darwin specific GPG Agent
      programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
      };
    };
  };
}
