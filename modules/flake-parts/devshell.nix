{ inputs, ... }:
{
  imports = [
    # add devshell module
    inputs.devshell.flakeModule
    # add git-hooks.nix module
    inputs.git-hooks.flakeModule
  ];

  perSystem =
    { pkgs, config, ... }:
    {
      pre-commit = {
        check.enable = true;
        settings = {
          enable = true;
          hooks = {
            nixfmt = {
              enable = true;
              settings.indent = 2;
              args = [ "--verify" ];
            };
            deadnix = {
              enable = true;
              settings.edit = false;
            };
            actionlint = {
              enable = true;
            };
            shellcheck = {
              enable = true;
            };
            shfmt = {
              enable = true;
              settings.indent = 2;
            };
          };
        };
      };
      devshells.default = {
        devshell = {
          name = "nix-env";
          motd = ''
            {202}{italic}Welcome to the {bold}nix-env!{reset}
          '';
          startup.pre-commit.text = config.pre-commit.shellHook;
        };
        packages = with pkgs; [
          statix # Linter
          nixfmt # Formatter
          nil # Language server
          nixd # Another language server
          deadnix # Scans for dead nix code
          actionlint # Linter for github actions
          shellcheck # Linter for shell scripts
          shfmt # Formatter for shell scripts
          manix # Options searcher for nix*
          tree # tree
          eza # ls replacement
          # TODO: Add devenv and pre-commit hook
        ];
      };
    };
}
