# ── Oh My Zsh ─────────────────────────────────────────────────────────────────
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="norm"

plugins=(
    zsh-autosuggestions
    sudo
    web-search
    z
)

ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#B6B09F"
zstyle ':omz:update' mode reminder
zstyle ':omz:update' frequency 13

source "$ZSH/oh-my-zsh.sh"

# ── Prompt ────────────────────────────────────────────────────────────────────
#export STARSHIP_CONFIG="$HOME/.config/starship/starship-omz.toml"
#eval "$(starship init zsh)"

# ── Editor ────────────────────────────────────────────────────────────────────
export EDITOR='nvim'

# ── PATH ──────────────────────────────────────────────────────────────────────
export PATH="$HOME/.local/bin:$HOME/.local/scripts:$PATH"

# Go
export PATH="/usr/local/go/bin:$PATH"

# Node / pnpm / bun
export PATH="/opt/nodejs/bin:$PATH"
export PNPM_HOME="/home/sabir/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
export PATH="$HOME/.pnpm-global/bin:$PATH"
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# Rust
export PATH="$HOME/.cargo/bin:$PATH"

# Zig
export PATH="$HOME/zig-linux-x86_64-0.13.0:$PATH"

# Ruby
export PATH="$HOME/bin:/home/sabir/.local/share/gem/ruby/bin:$PATH"

# JetBrains / IDEs
export PATH="/home/sabir/GoLand-2024.1.2/bin:$PATH"
export PATH="/opt/datagrip/bin:$PATH"
export PATH="$HOME/idea-IU-243.22562.145/bin:$PATH"

# Quartus / ModelSim
export PATH="/opt/altera_lite/25.1std/quartus/bin:$PATH"
export PATH="/opt/altera_lite/25.1std/modelsim_ase/bin:$PATH"

# Git
export GIT_CONFIG_GLOBAL="$HOME/.config/git/config"

# Docker
export DOCKER_BUILDKIT=0

# ── NVM ───────────────────────────────────────────────────────────────────────
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# ── Integrations ──────────────────────────────────────────────────────────────
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
[ -s "/home/sabir/.bun/_bun" ] && source "/home/sabir/.bun/_bun"
. "$HOME/.atuin/bin/env"
eval "$(atuin init zsh)"
eval "$(thefuck --alias)"
eval "$(thefuck --alias fk)"

# ── Aliases ───────────────────────────────────────────────────────────────────
# Neovim
alias vim='NVIM_APPNAME=nvim nvim'
alias tvim='NVIM_APPNAME=nvim-test nvim'
alias vi='vim'
alias vimconf="cd ~/.config/nvim/ && nvim ."
alias zshconf="nvim ~/.zshrc"

# Navigation & files
alias ls='eza --long --icons=always --no-filesize --no-time --no-user --git'
alias lt='lsd --tree --all --icon always --ignore-glob ".git|node_modules"'
alias files='yazi'
alias show="bat"
alias dotfiles="cd ~/dotfiles/"

# tmuxinator
alias txs='tmuxinator start'
alias txo='tmuxinator open'
alias txn='tmuxinator new'
alias txl='tmuxinator list'
alias txc='tmuxinator stop'

# Git
alias gsync='git fetch upstream && git checkout main && git merge upstream/main && git push origin main'

# Tools
alias ai='aichat'
alias disk="dua i"
alias monkeytype="toipe"
alias weather="curl wttr.in/essaouira"
alias packages='vim ~/dotfiles/nixos/users/sabir.nix'
alias goals="show ~/Projects/goals.md"
alias start-db="docker start booklab_redis_db booklab-db"
alias ziglings='find exercises -name "*zig" | entr -c zig build'

# ── Keybindings ───────────────────────────────────────────────────────────────
bindkey '^p' autosuggest-accept
bindkey -s '^f' "tmux-sessionizer\n"
