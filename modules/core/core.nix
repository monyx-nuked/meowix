{ lib, ... }:
let
  moduleName = "core/core";
  sharedSubstituters = {
    extra-substituters = [
      "https://install.determinate.systems"
      "https://nix-community.cachix.org"
      "https://devenv.cachix.org"
      "https://cachix.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.flakehub.com-3:hJuILl5sVK4iKm86JzgdXW12Y2Hwd5G07qKtHTOcDCM="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "devenv.cachix.org-1:w1cLUi8dv3hnoSPGAuibQv+f9TZLr6cv/Hm9XgU50cw="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    ];
  };

  # Shared nix settings for both platforms
  sharedNixSettings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    # Accept to install flake config instantly (CHECK FOR SUPPLY CHAIN ATTACK IF POSSIBLE)
    accept-flake-config = true;
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
      eval-cores = 0; # Det specific setting
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
        enable = lib.mkDefault true;
        lfs.enable = lib.mkDefault true;
      };
      home-manager = sharedHomeManager;
    };
  };
}
