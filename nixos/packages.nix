{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ ];
  programs.firefox.enable = true;
  nixpkgs.config.allowUnfree = true;
}
