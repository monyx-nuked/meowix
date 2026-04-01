{ config, ... }:
let
  presetName = "minimal";
  prefix = "presets";
in
{
  flake.modules.nixos."${prefix}/${presetName}" = {
    imports = config.flake.lib.resolveOS [
      "core/core"
      "core/i18n"
      "core/nh"
      "core/tmp"
      "core/timezone"
      "users"
      "shell"
    ];
  };
}
