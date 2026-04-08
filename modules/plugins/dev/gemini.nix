{
  flake.modules.homeManager."dev.gemini" =
    { config, ... }:
    {
      programs.gemini-cli = {
        enable = true;
      };

      sops.templates."gemini-env" = {
        content = ''
          GEMINI_API_KEY=${config.sops.placeholder."gemini_cli_api_key"}
        '';
        path = "${config.home.homeDirectory}/.config/environment.d/gemini.conf";
      };
    };
}
