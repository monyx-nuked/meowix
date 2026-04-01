let
  moduleName = "shell/utils";
in
{
  flake.modules.nixos.${moduleName} =
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
  flake.modules.homeManager.${moduleName} =
    { pkgs, lib, ... }:
    {
      programs.fzf.enable = true;
      home.packages = with pkgs; [
        broot
        skim
        mprocs
        gum
        tree
        just
        jq
        grc
        cloc
        xh
        fd
        html2text
        croc
      ];
      programs = {
        yazi.enable = lib.mkDefault true;
        eza = {
          git = lib.mkDefault true;
          enable = lib.mkDefault true;
        };
        ripgrep.enable = lib.mkDefault true;
        fd.enable = lib.mkDefault true;
        zoxide.enable = lib.mkDefault true;
        skim.enable = lib.mkDefault true;
        starship.enable = lib.mkDefault true;
        programs.fastfetch.enable = lib.mkDefault true;
      };
    };
}
