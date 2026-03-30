{ lib, ... }:
let
  moduleName = "core/core";
  sharedSubstituters = {
    substituters = [
      "https://cache.nixos.org/"
    ];
    trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
    ];
  };

  # Shared nix settings for both platforms
  sharedNixSettings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
  };

  sharedNix = lib.mkMerge [
    sharedSubstituters
    sharedNixSettings
  ];

  nixosSettings = lib.mkMerge [
    sharedNix
    {
      auto-optimise-store = true;
      cores = 3;
      max-jobs = 4;

    }
  ];

  sharedHomeManager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "hm-bak";
    overwriteBackup = true;
  };
in
{
  flake.modules = {
    nixos.${moduleName} = {
      # Enable for VSCode server and other progrsams
      programs.nix-ld.enable = true;
      # Disable NetworkManager-wait-online - most systems don't need to block boot for network
      # This saves ~5 seconds during boot
      systemd.network.wait-online.enable = false;
      # Switch backend to better one
      networking.networkmanager.wifi.backend = "iwd";
      # Enable ~/.local/bin in PATH for user-installed binaries (e.g. uv tools)
      environment.localBinInPath = true;
      # Enable unfree packages
      nixpkgs.config.allowUnfree = true;
      nix = {
        settings = lib.mkMerge [
          nixosSettings
          {
            trusted-users = [
              "root"
              "@wheel"
            ];
          }
        ];

        # nh will handle this
        gc.automatic = false;
        optimise.automatic = true;
      };
      programs.git = {
        enable = true;
        lfs.enable = true;
      };
      home-manager = sharedHomeManager;
    };
    darwin.${moduleName} = {
      nixpkgs.config.allowUnfree = true;
      nix = {
        settings = lib.mkMerge [
          sharedNix
          {
            trusted-users = [
              "root"
              "@admin"
            ];
          }
        ];

        # nh will handle this
        gc.automatic = false;
        optimise.automatic = true;
      };
      programs.git = {
        enable = true;
        lfs.enable = true;
      };
      home-manager = sharedHomeManager;
    };
  };
}
