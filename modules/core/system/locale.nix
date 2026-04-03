_: {
  flake.modules.nixos."system.locale" = {
    i18n.defaultLocale = "en_CA.UTF-8";
    i18n.extraLocaleSettings = {
      LC_ADDRESS = "uz_UZ.UTF-8";
      LC_IDENTIFICATION = "uz_UZ.UTF-8";
      LC_MEASUREMENT = "ru_RU.UTF-8";
      LC_MONETARY = "en_CA.UTF-8";
      LC_NAME = "en_CA.UTF-8";
      LC_NUMERIC = "ru_RU.UTF-8";
      LC_PAPER = "ru_RU.UTF-8";
      LC_TELEPHONE = "uz_UZ.UTF-8";
      LC_TIME = "uz_UZ.UTF-8";
    };

    services.xserver.xkb = {
      layout = "us";
      variant = "";
    };
  };
}
