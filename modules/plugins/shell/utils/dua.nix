{
  flake.modules.homeManager."shell.utils.dua" =
    { pkgs, ... }:
    {
      home.packages = [
        pkgs.dua
      ];
      xdg.configFile."dua-cli/config.toml".text = ''
        [keys]
        esc_navigates_back = true
      '';
    };
}
