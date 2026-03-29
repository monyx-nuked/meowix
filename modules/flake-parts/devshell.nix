{
  perSystem =
    { pkgs, ... }:
    {
      devshells.default = {
        name = "nix-env";
        motd = ''
          {202}{italic}Welcome to the {bold}nix-env!{reset}
        '';
        packages = with pkgs; [
          statix # Linter
          nixfmt # Formatter
          nil # Language server
          nixd # Another language server
          deadnix # Scans for dead nix code
          actionlint # Linter for github actions
          shellcheck # Linter for shell scripts
          shfmt # Formatter for shell scripts
          # TODO: Add devenv and pre-commit hook
        ];
      };
    };
}
