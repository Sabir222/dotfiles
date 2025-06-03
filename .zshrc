# ------------------------------------------------------------------------------
# Oh My Zsh Configuration
# ------------------------------------------------------------------------------

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Theme
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
#ZSH_THEME="awesomepanda"
# ZSH_THEME="sabir" # Alternative theme
 ZSH_THEME="robbyrussell" # Alternative theme

# Autosuggestion color
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"

# Oh My Zsh Update Settings
zstyle ':omz:update' mode reminder  # just remind me to update when it's time
zstyle ':omz:update' frequency 13   # check for updates every 13 days

# ------------------------------------------------------------------------------
# Plugins
# ------------------------------------------------------------------------------
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(
    eza
    zsh-autosuggestions
    # zsh-syntax-highlighting # Currently commented out
    sudo
    web-search
    z
)

# ------------------------------------------------------------------------------
# Source Oh My Zsh
# ------------------------------------------------------------------------------
# This line must be at the end of Oh My Zsh settings and plugins
source "$ZSH/oh-my-zsh.sh"

# ------------------------------------------------------------------------------
# Environment Variables & PATH
# ------------------------------------------------------------------------------

# Add user-specific bin directories to PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/scripts:$PATH"

# Go
export PATH="/usr/local/go/bin:$PATH"
export PATH="$HOME/go/bin:$PATH"

# Node.js (generic and nvm)
export PATH="/opt/nodejs/bin:$PATH"
export NVM_DIR="$HOME/.nvm"

# pnpm
export PNPM_HOME="/home/sabir/.local/share/pnpm"
export PATH="$PNPM_HOME:$PATH"
export PATH="$HOME/.pnpm-global/bin:$PATH" # For globally installed pnpm packages

# JetBrains IDEs & other tools
export PATH="/home/sabir/GoLand-2024.1.2/bin:$PATH"
export PATH="$HOME/DataGrip-2024.2.2/bin:$PATH"
export PATH="$HOME/idea-IU-243.22562.145/bin:$PATH"
export PATH="$HOME/zig-linux-x86_64-0.13.0:$PATH" # Zig compiler

# Git global config
export GIT_CONFIG_GLOBAL="$HOME/.config/git/config"

# ------------------------------------------------------------------------------
# Aliases
# ------------------------------------------------------------------------------
alias vi='vim'
alias ls='eza --long --icons=always --no-filesize --no-time --no-user --git'
alias show="bat"
alias dotfiles="cd ~/dotfiles/"
alias weather="curl wttr.in/essaouira"
alias ai='aichat'
alias monkeytype="toipe"

# Vim/Neovim Aliases
alias vim='NVIM_APPNAME=nvim nvim'
alias cvim='NVIM_APPNAME=nvim-chad nvim'
alias avim='NVIM_APPNAME=nvim-astro nvim'
alias vimconf="cd ~/.config/nvim/ && nvim ."
alias zshconfig="nvim ~/.zshrc"

# Project specific
alias goals="show ~/Projects/goals.md"

# ------------------------------------------------------------------------------
# Keybindings
# ------------------------------------------------------------------------------

# Bind Ctrl+L to accept autosuggestions (Oh My Zsh default is usually End or Right Arrow)
# Note: The original config had '^p', if you intended Ctrl+L, it should be '^l' (lowercase L)
# If you meant Ctrl+P, then '^p' is correct. I'm keeping original '^p'.
bindkey '^p' autosuggest-accept

# Tmux sessionizer
bindkey -s '^f' "tmux-sessionizer\n"

# ------------------------------------------------------------------------------
# Shell Integrations & Tooling
# ------------------------------------------------------------------------------

# Rust - Cargo
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"

# The Fuck - command line spell checker
eval $(thefuck --alias)
eval $(thefuck --alias fk) # Alias 'fk' for 'thefuck'

# NVM (Node Version Manager)
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# pnpm (PATH setup is done in the Environment Variables section)
# The pnpm script block for PATH modification is redundant if paths are set manually above.
# Original pnpm block for reference, can be removed if manual PATH additions are preferred:
# case ":$PATH:" in
#   *":$PNPM_HOME:"*) ;;
#   *) export PATH="$PNPM_HOME:$PATH" ;;
# esac

# ------------------------------------------------------------------------------
# User Customizations (End of File)
# ------------------------------------------------------------------------------
# Add any other personal configurations below this line.

# pnpm
export PNPM_HOME="/home/sabir/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
