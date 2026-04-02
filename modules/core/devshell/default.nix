{ inputs, ... }:
{
  imports = [
    inputs.devshell.flakeModule
  ];
  perSystem =
    { pkgs, ... }:
    {
      devshells.default = {
        devshell = {
          name = "meowix-env";
          motd = ''
            {202}{italic}Welcome to {underline}meowix project{reset}!
            {bold}This development shell contains necessary utilities to maintain this project.{reset}
          '';
          packages = [
            # Utilities #
            pkgs.nh # Yet another nix cli helper
            pkgs.eza # Modern, maintained replacement for ls
            pkgs.tree # Command to produce a depth indented directory listing
            pkgs.manix # Fast CLI documentation searcher for Nix
            # Language Servers #
            pkgs.nixd # Feature-rich Nix language server interoperating with C++ nix
            pkgs.nil # Yet another language server for Nix
            # Linters #
            pkgs.statix # Lints and suggestions for the nix programming language
            pkgs.actionlint # Static checker for GitHub Actions workflow files
            pkgs.shellcheck # Shell script analysis tool
            pkgs.deadnix # Find and remove unused code in .nix source files
            # Formatters #
            pkgs.nixfmt # Official formatter for Nix code
            pkgs.shfmt # Shell parser and formatter
          ];
          meta = {
            description = "Development shell made for this project";
            provider = "numtide's devshell";
          };
        };
      };
    };
}
