{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bibata-cursors
  ];

  # Set cursor theme system-wide
  environment.variables = {
    XCURSOR_THEME = "Bibata-Modern-Ice";
    XCURSOR_SIZE = "24";
  };

  # Optional: helps set cursor theme for X apps (even under Wayland)
  services.xserver = {
    exportConfiguration = true;
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;
}
