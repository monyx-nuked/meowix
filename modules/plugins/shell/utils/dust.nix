{
  flake.modules.homeManager."shell.utils.dust" =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.dust
      ];
      xdg.configFile."dust/config.toml".text = ''
        show-percent = true
      '';
    };
}
