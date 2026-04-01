{ config, ... }:
let
  presetName = "minimal";
  prefix = "presets";
in
{
  flake.modules = {
    nixos."${prefix}/${presetName}" = {
      imports = config.flake.lib.resolveOS [
        "core/core"
        "core/i18n"
        "core/nh"
        "core/tmp"
        "core/timezone"
        "users"
        "shell/fish"
        "shell/utils"
        "catppuccin"
      ];
    };
    homeModules."${prefix}/${presetName}" = {
      imports = config.flake.lib.resolveHm [
        "users"
        "shell/bat"
        "shell/direnv"
        "shell/fish"
        "shell/utils"
        "catppuccin"
      ];
    };
  };
}
