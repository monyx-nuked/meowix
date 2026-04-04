{ config, lib, ... }:
let
  shared = {
    substituters = {
      extra-substituters = [
        "https://install.determinate.systems"
        "https://nix-community.cachix.org"
        "https://devenv.cachix.org"
        "https://cachix.cachix.org"
        "https://cache.nixos-cuda.org"
      ];
      extra-trusted-public-keys = [
        "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
        "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
        "cache.nixos-cuda.org:74DUi4Ye579gUqzH4ziL9IyiJBlDpMRn9MBN8oNan9M="
      ];
    };
    nix_main_settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      auto-optimise-store = true;
    };
    nix_settings = lib.mkMerge [
      shared.substituters
      shared.nix_main_settings
    ];
    nixos_settings = lib.mkMerge [
      shared.nix_settings
      {
        cores = 3;
        max-jobs = 4;
        eval-cores = 0; # Det specific setting
      }
    ];
  };
in
{
  flake.modules = {
    nixos."system.nix" = {
      nix = {
        settings = lib.mkMerge [
          shared.nixos_settings
          {
            extra-trusted-users = [
              "root"
              "@wheel"
              config.flake.meta.user.username
            ];
          }
        ];

        # Leave it for nh
        gc.automatic = false;
        optimise.automatic = true;
      };
    };
    darwin."system.nix" = {
      nix = {
        settings = lib.mkMerge [
          shared.nixos_settings
          {
            extra-trusted-users = [
              "root"
              "@admin"
              config.flake.meta.user.username
            ];
          }
        ];

        # Leave it for nh
        gc.automatic = false;
        optimise.automatic = true;
      };
    };
  };
}
