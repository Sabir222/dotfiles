# Oh My Zsh configuration
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="awesomepanda"
# ZSH_THEME="sabir"
# ZSH_THEME="robbyrussell"

# Autosuggestions
ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#808080"
bindkey '^p' autosuggest-accept

# Update settings
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

# Load Oh My Zsh
source $ZSH/oh-my-zsh.sh

# Aliases
alias vim='NVIM_APPNAME=nvim nvim'
alias cvim='NVIM_APPNAME=nvim-chad nvim'
alias avim='NVIM_APPNAME=nvim-astro nvim'
alias vimconf="cd ~/.config/nvim/ && nvim ."

alias ls='eza --long --icons=always --no-filesize --no-time --no-user --git'
alias show="batcat"
alias dotfiles="cd ~/dotfiles/"
alias weather="curl wttr.in/essaouira"
alias ai='aichat'
alias monkeytype="toipe"
alias goals="show ~/Projects/goals.md"
alias zshconfig="nvim ~/.zshrc"

# Path exports
export PATH=$PATH:/home/sabir/nodejs/bin
export PATH=$PATH:/home/sabir/GoLand-2024.1.2/bin
export PATH=$PATH:/usr/local/go/bin
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/DataGrip-2024.2.2/bin
export PATH=$PATH:$HOME/idea-IU-243.22562.145/bin
export PATH=$PATH:$HOME/zig-linux-x86_64-0.13.0
export PATH=$PATH:$HOME/.local/scripts

# Tmux sessionizer shortcut
bindkey -s ^f "tmux-sessionizer\n"

# Rust environment
. "$HOME/.cargo/env"

# TheFuck aliases
eval $(thefuck --alias)
eval $(thefuck --alias fk)

# Node Version Manager (NVM)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# pnpm configuration
export PNPM_HOME="$HOME/.local/share/pnpm"
export PATH="$HOME/.pnpm-global/bin:$PATH"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

#git config
export GIT_CONFIG_GLOBAL="$HOME/.config/git/config"
