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
          statix # A linter
        ];
      };
    };
}
