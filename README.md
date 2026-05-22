# Sabir's Dotfiles

Personal Linux dotfiles managed with **GNU Stow**, built on **NixOS** with **Hyprland** as the compositor.

## Quick Start

```bash
# 1. Clone to $HOME
git clone https://github.com/Sabir222/dotfiles ~/dotfiles

# 2. Symlink everything with Stow
cd ~/dotfiles && stow .

# 3. For NixOS: symlink the flake to /etc/nixos
sudo rm -r /etc/nixos
sudo ln -s ~/dotfiles/nixos /etc/nixos

# 4. Rebuild NixOS
sudo nixos-rebuild switch --flake /etc/nixos#sabirlinux
```

---

## Stack Overview

| Category | Choice |
|---|---|
| **OS** | NixOS 25.05 (flake-based) |
| **WM/Compositor** | Hyprland |
| **Shell** | Zsh + Oh My Zsh |
| **Status Bar** | Waybar |
| **Launcher** | Wofi (+ Rofi) |
| **Terminal** | Alacritty (primary) / Kitty / Ghostty / Wezterm |
| **Multiplexer** | Tmux + TPM |
| **Editor** | Neovim (kickstart-based, lazy.nvim) |
| **Font** | CaskaydiaCove Nerd Font / JetBrainsMono Nerd Font |
| **Theme** | Rose Pine |

---

## Neovim

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with **lazy.nvim** package manager.

```bash
# Dependencies for Neovim
# (already on NixOS, or install manually:)
sudo nix-env -iA nixos.neovim nixos.ripgrep nixos.fd nixos.lazygit
```

The config lives in `~/.config/nvim/` with plugins in `lua/sabir/plugins/`. Active theme: **Kanagawa Paper**.

### Key plugins
- LSP, Treesitter, nvim-cmp (auto-completion)
- Neo-tree / Oil / Yazi (file browsing)
- Copilot / Avante (AI)
- Gitsigns / Lazygit / Diffview (Git)
- Telescope (fuzzy finding)
- Harpoon (quick navigation)
- Lualine (status line)

---

## Tmux

Uses **TPM** (Tmux Plugin Manager). Prefix: `Ctrl+a`.

```bash
# Install TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Install plugins (inside tmux)
# Press: Ctrl+a + I
```

Key features:
- Vim-style navigation (`h/j/k/l` to switch panes)
- Git branch & status in status line
- `Alt+0-9` to switch windows
- `Ctrl+f` to launch tmux-sessionizer
- `Ctrl+b` to toggle status bar

---

## Shell (Zsh)

### Requirements

```bash
# Oh My Zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Custom theme
cp ~/dotfiles/sabir.zsh-theme ~/.oh-my-zsh/custom/themes/

# Plugins
git clone https://github.com/zsh-users/zsh-autosuggestions \
  ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
```

### Aliases & Tools

| Tool | Aliases |
|---|---|
| **eza** | `ls` (with icons, git status) |
| **bat** | `show` |
| **yazi** | `files` |
| **lazygit** | `lg` (if bound) |
| **tmuxinator** | `txs`, `txo`, `txn`, `txl`, `txc` |
| **aichat** | `ai` |
| **dua** | `disk` (disk usage analyzer) |
| **toipe** | `monkeytype` (typing test) |
| **atuin** | Shell history search (Ctrl+r) |
| **thefuck** | `fuck` / `fk` (correct last command) |
| **zoxide** | `z` (smart cd, via omz plugin) |

### PATH includes
- `$HOME/.local/bin`, `$HOME/.local/scripts`, `$HOME/.cargo/bin`, `$HOME/go/bin`
- nvm (Node.js), pnpm, bun
- Zig, Go, Ruby gems
- JetBrains IDEs, Quartus/ModelSim

---

## Hyprland

Active compositor. Configs in `~/.config/hypr/`.

| File | Purpose |
|---|---|
| `hyprland.conf` | Keybinds, monitors, animations, input |
| `hyprlock.conf` | Lock screen with clock, date, wallpaper |
| `hypridle.conf` | Auto-lock after 5 min idle |
| `hyprpaper.conf` | Wallpaper preload & set |

### Keybinds (Super = Windows key)

| Key | Action |
|---|---|
| `Super+Return` | Terminal (Alacritty) |
| `Super+W` | Random wallpaper |
| `Super+Q` | Kill active window |
| `Super+M` | Exit Hyprland |
| `Super+E` | File manager (Dolphin) |
| `Super+D` | App launcher (Wofi) |
| `Super+B` | Browser (Brave) |
| `Super+V` | Toggle floating |
| `Super+{1-0}` | Switch workspace |
| `Super+Shift+{1-0}` | Move window to workspace |
| `Super+{H,J,K,L}` | Focus left/down/up/right |

---

## Git

Global config in `~/.config/git/config` with:
- **Delta** as diff pager
- GPG commit signing (key: `C3B9D7943CC95559`)
- `gh:` shorthand for `git@github.com:`
- `sk:` shorthand for `git@github.com:Sabir222/`

```bash
# GPG key reminder
# If you change PCs, update your public key on GitHub
```

---

## Scripts

`~/.local/scripts/`:
- **tmux-sessionizer** — Fuzzy-find projects in `~/Desktop/` and `~/Projects/`, create/attach tmux sessions

---

## NixOS Modules

| Module | Purpose |
|---|---|
| `bootloader.nix` | systemd-boot, EFI |
| `desktop.nix` | Hyprland, Cinnamon fallback, LightDM |
| `fonts.nix` | Nerd Fonts (Fira Code, JetBrains Mono, Caskaydia Cove) |
| `networking.nix` | NetworkManager |
| `sound.nix` | PipeWire (ALSA, PulseAudio) |
| `packages.nix` | System packages (Bibata cursors, Firefox) |
| `zsh.nix` | Zsh as default shell |
| `tempApps.nix` | JetBrains DataGrip |

### User packages (from `users/sabir.nix`)
bat, ripgrep, fd, fzf, eza, btop, tmux, git, neovim, waybar, ghostty, alacritty, wofi, spotify, brave, starship, stow, swww, zoxide, thefuck, clang, gcc, python3, go, rustc, cargo, nodejs_22, pnpm_9, and more.

---

## Manual Steps After Setup

```bash
# 1. Tmux sessionizer permissions
chmod +x ~/.local/scripts/tmux-sessionizer

# 2. Install Lazygit
# (via your package manager or NixOS)

# 3. Install Rust toolchain
# curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# 4. Install eza (via cargo, or NixOS)
# cargo install eza

# 5. Install Atuin
# bash <(curl https://raw.githubusercontent.com/atuinsh/atuin/main/install.sh)

# 6. Set up GPG key for commit signing
gpg --full-generate-key
git config --global user.signingkey YOUR_KEY
git config --global commit.gpgSign true

# 7. Tmux source
tmux source ~/.tmux.conf
```

---

## GPG Key Reminder

If you change PCs or generate a new GPG key, update your public GPG key on GitHub to keep commit signing working correctly.
