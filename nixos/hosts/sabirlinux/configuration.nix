{ config, pkgs, ... }: {
  imports = [
    ./hardware-configuration.nix
    ../../modules/tempApps.nix
    ../../modules/bootloader.nix
    ../../modules/desktop.nix
    ../../modules/fonts.nix
    ../../modules/networking.nix
    ../../modules/sound.nix
    ../../modules/packages.nix
    ../../modules/zsh.nix
    ../../users/sabir.nix
  ];
  networking.hostName = "sabirlinux";
  time.timeZone = "Africa/Casablanca";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "ar_MA.UTF-8";
    LC_IDENTIFICATION = "ar_MA.UTF-8";
    LC_MEASUREMENT = "ar_MA.UTF-8";
    LC_MONETARY = "ar_MA.UTF-8";
    LC_NAME = "ar_MA.UTF-8";
    LC_NUMERIC = "ar_MA.UTF-8";
    LC_PAPER = "ar_MA.UTF-8";
    LC_TELEPHONE = "ar_MA.UTF-8";
    LC_TIME = "ar_MA.UTF-8";
  };

  system.stateVersion = "25.05";
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  environment.variables.EDITOR = "nvim";
}
