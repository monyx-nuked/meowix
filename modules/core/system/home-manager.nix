_:
let
  home-manager = {
    # Additional settings for home-manager
    backupFileExtension = "hm-bak";
    overwriteBackup = true;
  };
in
{
  flake.modules = {
    nixos."system.home-manager" = {
      inherit home-manager;
    };
    darwin."system.home-manager" = {
      inherit home-manager;
    };
  };
}
