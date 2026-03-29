{
  perSystem =
    { pkgs, ... }:
    {
      devshells.default = {
        name = "nix-env";
        motd = ''
          {202}Welcome to the {bold}nix-env!{reset}
        '';
        packages = with pkgs; [
          statix # Linter
          nixfmt # Formatter
          nil # Language server
          nixd # Another language server
          deadnix # Scans for dead nix code
        ];
      };
    };
}
