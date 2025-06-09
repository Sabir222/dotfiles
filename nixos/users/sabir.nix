{ pkgs, ... }: {
  users.users.sabir = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "sabir";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
      neovim
      waybar
      ghostty
      wofi
      spotify
      bat
      ripgrep
      neofetch
      wget
      nnn
      curl
      btop
      file
      fd
      jq
      clang
      gcc
      zoxide
      fzf
      tmux
      python313
      unzip
      xclip
      wl-clipboard
      starship
      go
      stow
      brave
      openssl
      openssh
      git
      alacritty
      rustc
      cargo
      eza
      thefuck
      gnumake
      zsh-autosuggestions
      nodejs_22
      zsh
    ];
  };

  services.displayManager.autoLogin.enable = true;
  services.displayManager.autoLogin.user = "sabir";
}
