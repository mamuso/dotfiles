# Mamuso's dotfiles

Modern macOS dotfiles with support for fnm, pnpm, Claude Code, Ghostty, and more.

Inspired by [Nicola Paolucci's article](https://www.atlassian.com/git/tutorials/dotfiles) about storing and consuming dotfiles.

These are my dotfiles (for macOS). You are free to use anything you want, but at your own risk.

## What's Included

### Shell Configuration
- **Zsh** with Oh My Zsh and Powerlevel10k theme
- Modular configuration (`.zshrc`, `.zsh_aliases`, `.zsh_exports`, `.zshenv`)
- Modern aliases for git, pnpm, and development tools
- McFly for intelligent command history search

### Development Tools
- **fnm** (Fast Node Manager) instead of nvm
- **pnpm** for package management
- **rbenv** for Ruby version management
- **Git** with helpful aliases and worktree support
- **GitHub CLI** (gh) with custom config

### Editors & Terminal
- **Vim** with Vim Plug, Night Owl theme, NERDTree, and CtrlP
- **Ghostty** terminal themes (Catppuccin variants + custom Vercel theme)

### Keyboard & Tools
- **Karabiner Elements** keyboard customization config
- **Claude Code** configuration awareness

## Prerequisites

Before installing, ensure you have:

1. **Xcode Command Line Tools** (includes git)
   ```bash
   sudo softwareupdate -i -a
   xcode-select --install
   ```

2. **curl** (usually pre-installed on macOS)

## Installation

Run the following command to install the dotfiles:

```bash
# Full install (default) - everything
curl -Lks https://raw.githubusercontent.com/mamuso/dotfiles/main/.init/install.sh | /bin/bash

# Skills/agents only - AI configs for Claude, Cursor, Codex, OpenCode
curl -Lks https://raw.githubusercontent.com/mamuso/dotfiles/main/.init/install.sh | bash -s -- --skills-only

# Dotfiles only - shell/editor configs, no AI stuff
curl -Lks https://raw.githubusercontent.com/mamuso/dotfiles/main/.init/install.sh | bash -s -- --dotfiles-only
```

The full install will:
1. Clone the dotfiles repository to `~/.dotfiles/`
2. Create a bare git repository at `~/.dotfiles/`
3. Check out the dotfiles to your home directory

**Skills-only** installs: `.agents/`, `.claude/`, `.cursor/`, `.codex/`, `.opencode/`, `skills/`

**To upgrade from partial to full install:**
```bash
config sparse-checkout disable && config checkout
```

## Bootstrap Options

After installation, the bootstrap script (`.init/bootstrap.sh`) will prompt you to:

- **Xcode Command Line Tools**: Install developer tools
- **Zsh**: Install Oh My Zsh and Powerlevel10k theme
- **Homebrew**: Install package manager and common packages
- **Git**: Configure user name, email, and GitHub CLI
- **Node**: Install fnm and pnpm

You can run the bootstrap script again anytime:

```bash
~/.init/bootstrap.sh
```

## Managing Dotfiles

This repository uses a **bare Git repository** approach. Instead of using `git` commands directly, use the `config` alias:

```bash
# Check status
config status

# Add files
config add .zshrc

# Commit changes
config commit -m "Update zsh configuration"

# Push to remote
config push
```

The `config` alias is defined in `.zshrc:2` and points to:
```bash
/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME
```

### Important: Only tracked files appear in status

The repository is configured with `status.showUntrackedFiles no` to avoid showing all files in your home directory. Only explicitly tracked files will appear in `config status`.

## Manual Configuration Required

Some files contain sensitive information and are **not** tracked in this repository. You'll need to set these up manually:

### Git Personal Information

Create `~/.gitconfig.local` with your personal information:

```ini
[user]
    name = Your Name
    email = your.email@example.com
```

The main `.gitconfig` uses Git's include directive to load this file.

### Other Sensitive Files

- `~/.ssh/` - SSH keys
- `~/.npmrc` - npm authentication tokens
- `~/.env*` - Environment-specific variables

## macOS System Preferences

Since macOS settings can be fragile across versions, this repository no longer includes automated `defaults write` commands. Here are the most valuable manual settings to configure:

### Keyboard & Input
```bash
# Fast key repeat rate
defaults write NSGlobalDomain KeyRepeat -int 1
defaults write NSGlobalDomain InitialKeyRepeat -int 10
```

### Trackpad
- System Preferences → Trackpad → Point & Click → Tap to click
- System Preferences → Trackpad → Scroll & Zoom → Natural scrolling

### Dock
```bash
# Autohide dock
defaults write com.apple.dock autohide -bool true

# Smaller dock size
defaults write com.apple.dock tilesize -int 48

killall Dock
```

### Finder
```bash
# Show hidden files
defaults write com.apple.finder AppleShowAllFiles -bool true

# Show file extensions
defaults write NSGlobalDomain AppleShowAllExtensions -bool true

# Show path bar
defaults write com.apple.finder ShowPathbar -bool true

killall Finder
```

For more macOS defaults options, visit [macos-defaults.com](https://macos-defaults.com/).

## Post-Installation

### Terminal Permissions

Make sure your terminal app has **Full Disk Access**:
1. Go to **System Settings → Privacy & Security → Full Disk Access**
2. Add your terminal app (Ghostty, iTerm2, Terminal.app, etc.)

### Reload Shell Configuration

After making changes to shell files, reload your configuration:

```bash
source ~/.zshrc
```

### Check Claude Code Status

Run the status checker to see your Claude Code configuration:

```bash
~/.init/claude.sh
```

## Troubleshooting

### `config` alias not working

Make sure you've sourced your `.zshrc`:
```bash
source ~/.zshrc
```

Or restart your terminal.

### fnm not found

Make sure `.zsh_exports` is loaded and fnm is installed:
```bash
brew install fnm
source ~/.zshrc
```

### Changes not appearing in `config status`

Remember, only tracked files appear. To track a new file:
```bash
config add <filename>
```

### Bare repository confusion

If you're new to the bare repository approach:
- Your **actual files** are in `$HOME` (e.g., `~/.zshrc`)
- The **git repository** is in `~/.dotfiles/`
- Use `config` (not `git`) to manage these files
- The working tree is `$HOME`, not a subdirectory

## Tools Cheat Sheet

### pnpm
```bash
pn          # pnpm
pni         # pnpm install
pnr         # pnpm run
pnx         # pnpm exec
```

### Git Worktrees
```bash
gwl         # git worktree list
gwa         # git worktree add
gwr         # git worktree remove
```

### System Updates
```bash
update      # Update Homebrew packages and cleanup
```

## File Structure

```
~/.dotfiles/           # Bare git repository
~/.init/               # Installation scripts
  ├── install.sh       # Initial setup (--all, --skills-only, --dotfiles-only)
  ├── bootstrap.sh     # Interactive setup orchestrator
  ├── brew.sh          # Homebrew packages
  ├── zsh.sh           # Oh My Zsh + Powerlevel10k
  ├── git.sh           # Git configuration
  ├── node.sh          # fnm + pnpm setup
  └── claude.sh        # Claude Code status checker
~/.config/             # Modern tool configurations
  ├── gh/              # GitHub CLI
  ├── ghostty/         # Ghostty terminal themes
  └── karabiner/       # Keyboard remapping
~/.agents/skills/      # AI skill definitions (24 skills)
~/.claude/             # Claude Code settings + statusline
~/.cursor/skills/      # Cursor IDE skills (symlinks)
~/.codex/skills/       # Codex skills (symlinks)
~/.opencode/skills/    # OpenCode skills (symlinks)
~/.zshrc              # Main Zsh config
~/.zsh_aliases        # Command aliases
~/.zsh_exports        # PATH and environment variables
~/.zshenv             # Zsh environment setup
~/.vimrc              # Vim configuration
~/.p10k.zsh           # Powerlevel10k theme config
```

## Credits

- [Nicola Paolucci](https://www.atlassian.com/git/tutorials/dotfiles) - Bare repository approach
- [Oh My Zsh](https://ohmyz.sh/) - Zsh framework
- [Powerlevel10k](https://github.com/romkatv/powerlevel10k) - Zsh theme
- [fnm](https://github.com/Schniz/fnm) - Fast Node Manager
- [pnpm](https://pnpm.io/) - Fast package manager

## License

These dotfiles are provided as-is. Feel free to use, modify, and distribute as you wish.
