{
  flake.modules = {
    nixos."system.tty" =
      { pkgs, ... }:
      {
        console = {
          font = "Lat2-Terminus16";
          packages = with pkgs; [ terminus_font ];
          useXkbConfig = true;
        };
      };
  };
}
