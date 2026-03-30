{ config, ... }:
let
  moduleName = "core/nh";
in
{
  flake.modules.nixos.${moduleName} =
    { pkgs, ... }:
    {
      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 7d --keep 10";
        flake = "/home/${config.flake.meta.user.username}/${config.flake.meta.user.github.repo}";
      };

      environment.systemPackages = with pkgs; [
        nh
        nix-output-monitor
        dix
      ];
    };
  flake.modules.darwin.${moduleName} =
    { pkgs, ... }:
    {
      programs.nh = {
        enable = true;
        clean.enable = true;
        clean.extraArgs = "--keep-since 7d --keep 10";
        flake = "/Users/${config.flake.meta.user.username}/${config.flake.meta.user.github.repo}";
      };

      environment.systemPackages = with pkgs; [
        nh
        nix-output-monitor
        dix
      ];
    };
}
