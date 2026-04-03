_: {
  flake.modules.nixos."shell.utils" =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        wget
        curl
        socat
        xdg-utils
        unzip
        unrar
        p7zip
        killall
        nixfmt
      ];
    };
  flake.modules.homeManager."shell.utils" =
    { pkgs, lib, ... }:
    {
      home.packages = with pkgs; [
        broot
        mprocs
        gum
        tree
        just
        jq
        cloc
        xh
        fd
        html2text
        croc
      ];
      programs = {
        bat.enable = lib.mkDefault true;
        yazi.enable = lib.mkDefault true;
        eza = {
          git = lib.mkDefault true;
          enable = lib.mkDefault true;
        };
        ripgrep.enable = lib.mkDefault true;
        fzf.enable = lib.mkDefault true;
        fd.enable = lib.mkDefault true;
        zoxide.enable = lib.mkDefault true;
        starship.enable = lib.mkDefault true;
        fastfetch.enable = lib.mkDefault true;
        # My favourite editor in case of backup
        helix = {
          enable = lib.mkDefault true;
          defaultEditor = lib.mkDefault true;
        };
        # IMPORTANT!
        git = {
          enable = true;
          lfs.enable = true;
        };
      };
    };
}
