{ ... }: {
  services.xserver.enable = true;
  services.xserver.displayManager.lightdm.enable = true;
  services.xserver.desktopManager.cinnamon.enable = true;
  services.xserver.xkb.layout = "us";
  programs.hyprland.enable = true;
}
