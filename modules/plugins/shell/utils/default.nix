{ config, ... }:
{
  flake.modules = {
    nixos."shell.utils" = {
      imports = config.flake.lib.resolve [
        # Has no use currently but keep
      ];
    };
    darwin."shell.utils" = {
      imports = config.flake.lib.resolve_darwin [
        # Has no use currently but keep
      ];
    };
    homeManager."shell.utils" = {
      imports = config.flake.lib.resolve_hm [
        "shell.utils.bat?"
        "shell.utils.eza?"
        "shell.utils.rg?"
        "shell.utils.tldr?"
        "shell.utils.z?"
        "shell.utils.fzf?"
        "shell.utils.fd?"
        # Disabled because for WSL ( can be enabled regardless )
        # "shell.utils.rga?"
        "shell.utils.delta?"
        "shell.utils.dust?"
        "shell.utils.dua?"
        "shell.utils.just?"
        "shell.utils.xh?"
      ];
    };
  };
}
