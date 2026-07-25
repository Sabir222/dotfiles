# Sabir's Dotfiles

Personal Linux configuration, managed with **[GNU Stow](https://www.gnu.org/software/stow/)**.  
One repo, many machines — shell, editor, window managers, and a carefully tuned terminal stack.

```text
~/dotfiles  ──stow──►  ~/.config, ~/.zshrc, ~/.tmux.conf, …
```

**Repo:** [github.com/Sabir222/dotfiles](https://github.com/Sabir222/dotfiles)

---

## Quick start

```bash
# 1. Clone into $HOME
git clone git@github.com:Sabir222/dotfiles.git ~/dotfiles

# 2. Symlink everything with Stow
cd ~/dotfiles && stow .

# 3. (Optional) NixOS system config
sudo rm -rf /etc/nixos
sudo ln -s ~/dotfiles/nixos /etc/nixos
sudo nixos-rebuild switch --flake /etc/nixos#sabirlinux
```

Stow links package contents into `$HOME`. Edit files under `~/dotfiles` — those are the source of truth.

---

## Stack

| Layer | Choice |
|---|---|
| **OS** | Fedora / NixOS (flake under `nixos/`) |
| **Compositor (active)** | **Sway** (Wayland) |
| **Also present** | Hyprland, i3, bspwm, xmonad |
| **Terminal** | **Ghostty** (default) · Alacritty · Kitty · WezTerm |
| **Font** | **CaskaydiaCove Nerd Font** (everywhere that matters) |
| **Shell** | Zsh + Oh My Zsh (`norm` theme) + Atuin |
| **Prompt extras** | Starship configs (Rose Pine palette) available |
| **Multiplexer** | Tmux + TPM · tmuxinator |
| **Editor** | Neovim (kickstart + lazy.nvim) · Kanagawa Paper Ink |
| **Launcher** | Wofi (Sway) · Rofi |
| **Bar** | i3blocks (Sway) · Waybar / polybar / xmobar configs |
| **Browser** | Brave |
| **File manager** | Dolphin |
| **Notifications** | Mako |
| **Git** | Delta pager · GPG signing · `gh:` / `sk:` URL shortcuts |

---

## Ghostty

**Default terminal** on Sway (`$terminal` → `ghostty`, Super+Return).

Config path (stowed):

```text
.config/ghostty/config.ghostty
  → ~/.config/ghostty/config.ghostty
```

Ghostty 1.3+ loads **`config.ghostty`** (not the older bare `config` name).

### Font — CaskaydiaCove Nerd Font

The terminal is built around **[CaskaydiaCove Nerd Font](https://www.nerdfonts.com/font-downloads)** (Cascadia Code + Nerd Font glyphs):

| Setting | Value |
|---|---|
| **Family** | `CaskaydiaCove Nerd Font` |
| **Size** | `16` |

It’s the same family as Alacritty, so shell icons, Starship/Oh My Zsh glyphs, and `eza`/`ls` symbols stay consistent when switching emulators. This font is intentional and non-negotiable for this setup — the ligatures and icon coverage are why it stuck.

Install on Fedora:

```bash
# Example: get a Nerd Fonts package or install the TTF/OTF into ~/.local/share/fonts
fc-cache -fv
ghostty +list-fonts | grep -i caskaydia
```

### Look & feel

Colours and metrics are aligned with the Alacritty config:

| | |
|---|---|
| Background | `#171717` |
| Foreground | `#7F8CAA` |
| Padding | `2` × `1` |
| Cursor | Solid **block** (Vim-style), no blink |
| Window | No client-side decorations (clean under Sway) |
| `$TERM` | `xterm-256color` |

Shell integration keeps **sudo** / **title** helpers but uses `no-cursor` so the prompt doesn’t force a thin bar cursor.

### Sway notes

- Super+Return and session autostart use Ghostty via `set $terminal ghostty`.
- On Sway, `/etc/sway/config.d/*` (Fedora `sway-systemd`) is included so D-Bus-activated apps get `WAYLAND_DISPLAY` — required for Ghostty from Wofi.

Reload after config edits:

```bash
# running instance
pkill -SIGUSR2 ghostty
# or open a new window
```

---

## Sway

Active Wayland session. Config: `.config/sway/config`.

| Key | Action |
|---|---|
| `Super+Return` | Terminal (**Ghostty**) |
| `Super+Q` | Kill focused window |
| `Super+E` | File manager (Dolphin) |
| `Super+D` | App launcher (Wofi) |
| `Super+B` / `Super+I` | Brave / Brave incognito |
| `Super+W` | Random wallpaper |
| `Super+M` | Exit Sway (confirm) |
| `Super+{H,J,K,L}` | Focus (vim) |
| `Super+Shift+{H,J,K,L}` | Move window |
| `Super+{1–0}` | Workspaces 1–10 |
| `Super+Shift+{1–0}` | Move to workspace |
| `Super+R` | Resize mode |
| `Super+F` | Fullscreen |

Also in this config: dual-monitor layout, mako, swayidle/swaylock, cliphist, i3blocks bar.

---

## Neovim

Based on [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim) with **lazy.nvim**.  
Lives in `.config/nvim/` · plugins under `lua/sabir/plugins/`.

**Theme:** `kanagawa-paper-ink`

Notable pieces: LSP, Treesitter, nvim-cmp, Telescope, Harpoon, Neo-tree / Oil / Yazi, Gitsigns, Lazygit, Diffview, Lualine, Copilot / Avante.

---

## Tmux

Prefix: **`Ctrl+a`** · TPM plugins.

```bash
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# inside tmux: Ctrl+a then I
```

- Vim-style pane focus (`h/j/k/l`)
- Git-aware status line
- `Ctrl+f` → **tmux-sessionizer** (fuzzy project sessions)
- Layouts/projects via **tmuxinator**

---

## Shell (Zsh)

Oh My Zsh theme: **`norm`**. Custom theme file in-repo: `sabir.zsh-theme` (optional install into `~/.oh-my-zsh/custom/themes/`).

### Handy tools & aliases

| Tool | Role |
|---|---|
| **eza** | `ls` with icons + git |
| **bat** | `show` |
| **yazi** | `files` |
| **atuin** | Smarter history (`Ctrl+r`) |
| **zoxide** | Smart `cd` (`z`) |
| **thefuck** | `fuck` / `fk` |
| **dua** | `disk` |
| **tmuxinator** | `txs`, `txo`, `txn`, … |
| **aichat** | `ai` |

`PATH` picks up `~/.local/bin`, `~/.local/scripts`, Cargo, Go, nvm/pnpm/bun, and more (see `.zshrc`).

---

## Git

Global config: `.config/git/config`

- **Delta** as the diff pager
- GPG commit signing
- Shorthands: `gh:` → `git@github.com:`, `sk:` → `git@github.com:Sabir222/`

If you rotate machines or regenerate a signing key, update the public key on GitHub.

---

## Scripts

`.local/scripts/`:

| Script | Purpose |
|---|---|
| **tmux-sessionizer** | Fuzzy-find under `~/Desktop` / `~/Projects`, create or attach a tmux session |

```bash
chmod +x ~/.local/scripts/tmux-sessionizer
```

---

## Hyprland & friends

Hyprland configs remain under `.config/hypr/` (hyprland / hyprlock / hypridle / hyprpaper).  
Other WM configs (i3, bspwm, xmonad, …) are kept for alternate sessions — Sway is the daily driver on this machine.

---

## NixOS

Flake + modules under `nixos/`:

| Module | Role |
|---|---|
| `bootloader.nix` | systemd-boot, EFI |
| `desktop.nix` | Desktop session packages |
| `fonts.nix` | Nerd Fonts (including **Caskaydia Cove**) |
| `networking.nix` | NetworkManager |
| `sound.nix` | PipeWire |
| `packages.nix` | System packages |
| `zsh.nix` | Default shell |
| `tempApps.nix` | Extra apps |

User package set lives in `nixos/users/`.

---

## Layout

```text
dotfiles/
├── .config/
│   ├── ghostty/config.ghostty    # primary terminal
│   ├── alacritty/                # reference colours / fallback
│   ├── sway/                     # active compositor
│   ├── nvim/                     # editor
│   ├── starship/                 # prompt themes
│   ├── git/                      # global git + delta
│   ├── hypr/ i3/ waybar/ wofi/ … # other desktop pieces
│   └── …
├── .local/scripts/               # tmux-sessionizer, etc.
├── nixos/                        # flake + modules
├── Pictures/                     # wallpapers / assets
├── .zshrc · .tmux.conf · .wezterm.lua
├── sabir.zsh-theme
└── README.md
```

---

## After install checklist

```bash
# Fonts (CaskaydiaCove Nerd Font must be installed for Ghostty icons)
fc-list | grep -i CaskaydiaCove

# Stow
cd ~/dotfiles && stow .

# TPM
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

# Scripts
chmod +x ~/.local/scripts/*

# Optional: Atuin, rustup, language toolchains — as needed for your host
```

---

## License / credit

Personal config — steal freely, expect sharp edges.  
Thanks to the maintainers of Ghostty, Sway, Neovim kickstart, Nerd Fonts, and everyone whose configs were adapted along the way.
