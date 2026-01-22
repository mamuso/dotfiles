# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a macOS dotfiles repository managed using a bare Git repository approach, inspired by [Nicola Paolucci's article](https://www.atlassian.com/git/tutorials/dotfiles). The dotfiles are stored in a bare repository at `~/.dotfiles/` and the working tree is `$HOME`, allowing configuration files to be versioned without a traditional Git repository in the home directory.

## Key Architecture

### Special Git Alias

The repository uses a custom `config` alias instead of `git` to manage dotfiles:

```bash
config="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"
```

This alias is defined in `.zshrc:2` and should be used for all Git operations in this repository (e.g., `config status`, `config add`, `config commit`, `config push`).

### File Structure

- **Root dotfiles**: `.zshrc`, `.zsh_aliases`, `.zsh_exports`, `.zshenv`, `.vimrc`, `.p10k.zsh`, `.profile`
- **Modern configurations**: `.config/` directory for tool-specific configs
  - `gh/config.yml` - GitHub CLI configuration
  - `ghostty/themes/` - Ghostty terminal themes (Catppuccin + Vercel)
  - `karabiner/karabiner.json` - Keyboard remapping configuration
- **Installation scripts**: `.init/` directory contains modular setup scripts
  - `install.sh` - Clones bare repo, supports `--all`, `--skills-only`, `--dotfiles-only`
  - `bootstrap.sh` - Interactive setup orchestrator
  - `brew.sh` - Homebrew and package installation
  - `zsh.sh` - Oh My Zsh and Powerlevel10k setup
  - `git.sh` - Git configuration (user name, email, gh CLI)
  - `node.sh` - fnm and pnpm installation
  - `claude.sh` - Claude Code configuration status checker

### Shell Configuration

The shell configuration is modular:

1. **`.zshrc`** - Main Zsh configuration file
   - Loads `.zsh_aliases` and `.zsh_exports` using a loop (.zshrc:5-8)
   - Configures Oh My Zsh with Powerlevel10k theme
   - Enabled plugins: `dotenv`, `git`, `sudo`, `vscode`, `rbenv` (.zshrc:31)
   - Initializes McFly for command history search (.zshrc:41)

2. **`.zshenv`** - Zsh environment setup (loaded first)
   - Sets up initial PATH configuration
   - Loaded before .zshrc for all zsh instances

3. **`.zsh_exports`** - PATH configuration and environment variables
   - Sets up paths for Homebrew, rbenv, fnm, and pnpm
   - Initializes fnm (Fast Node Manager) with `--use-on-cd` flag
   - Configures pnpm home directory
   - Configures Ruby build options for rbenv

4. **`.zsh_aliases`** - Custom command aliases
   - **Git shortcuts**: g, ga, gs, gcm, gd, gp
   - **Git worktrees**: gwl, gwa, gwr
   - **pnpm aliases**: pn, pni, pnr, pnx
   - **Claude Code**: claude (shortcut for claude-code)
   - **Git cleanup**: `gclear` - Removes local branches deleted remotely
   - **Bulk operations**: `gup` / `gupcl` - Bulk git pull across directories
   - **System updates**: `update` - Updates and cleans Homebrew packages

### Vim Configuration

`.vimrc` configures Vim with:
- Vim Plug plugin manager
- Night Owl color scheme
- NERDTree (Ctrl+O to toggle)
- CtrlP fuzzy finder
- lightline status bar
- Custom key mappings (jk → ESC, space as leader)

### Modern Development Tools

#### Node.js Management (fnm + pnpm)

The repository uses **fnm** (Fast Node Manager) instead of nvm, and **pnpm** instead of npm:

- **fnm** installed via Homebrew
- Automatic node version switching with `--use-on-cd`
- **pnpm** for fast, efficient package management
- No more `~/.npm-global` directory needed

#### Terminal Configuration

- **Ghostty**: Modern GPU-accelerated terminal
  - Custom themes in `.config/ghostty/themes/`
  - Includes Catppuccin variants (frappe, latte, macchiato, mocha)
  - Custom Vercel theme

#### Keyboard Customization

- **Karabiner Elements**: Keyboard remapping configuration
  - Config tracked at `.config/karabiner/karabiner.json`

#### Claude Code Integration

- **Status Checker**: `.init/claude.sh` shows configuration state
- **Not Tracked**: `.claude.json` (runtime state file, changes frequently)
- **Skills Directory**: `~/.claude/skills/` (user-managed)

## Working with This Repository

### Making Changes to Dotfiles

1. Use the `config` alias instead of `git`:
   ```bash
   config status
   config add .zshrc
   config commit -m "Update zsh configuration"
   config push
   ```

2. The repository is configured with `status.showUntrackedFiles no` to avoid showing all home directory files. Only explicitly tracked files will appear in `config status`.

3. When editing shell configuration files:
   - Test changes by sourcing the file: `source ~/.zshrc`
   - Changes to `.zshenv`, `.zsh_exports`, or `.zsh_aliases` require reloading `.zshrc`
   - `.zshenv` is loaded for all zsh instances, use for environment-wide settings

### Selective Installation

The install script supports three modes via command-line flags:

```bash
# Full install (default) - everything
curl -fsSL <url>/install.sh | bash

# Skills/agents only - AI configs for Claude, Cursor, Codex, OpenCode
curl -fsSL <url>/install.sh | bash -s -- --skills-only

# Dotfiles only - shell/editor configs, no AI stuff
curl -fsSL <url>/install.sh | bash -s -- --dotfiles-only
```

**Skills-only includes:**
- `.agents/` - Skill definitions (24 skills)
- `.claude/` - Claude Code settings and statusline
- `.cursor/`, `.codex/`, `.opencode/` - Symlinked skills for other AI tools
- `skills/` - Additional skill symlinks

**To upgrade from partial to full install:**
```bash
config sparse-checkout disable && config checkout
```

### Testing Installation Scripts

The `.init/` scripts are designed to be idempotent but may require testing in a clean environment. Each script can be run independently:

```bash
./.init/brew.sh        # Install Homebrew packages
./.init/git.sh         # Configure Git
./.init/zsh.sh         # Install Oh My Zsh and Powerlevel10k
./.init/node.sh        # Install fnm and pnpm
./.init/claude.sh      # Check Claude Code configuration status
```

### Sensitive Files and Privacy

The following files contain sensitive information and are **NOT tracked** in the repository:

**Explicitly Excluded (in .gitignore):**
- `.ssh/` - SSH keys
- `*.pem`, `*.key` - Certificate files
- `.env`, `.env.*` - Environment variables
- `.gitconfig.local` - Personal Git information
- `.npmrc` - npm authentication tokens
- `*_history` - Shell command history
- `.claude.json` - Claude Code runtime state
- `.claude/` - Claude Code local data

**Managed via Git Include Directive:**
- `.gitconfig` uses `[include] path = ~/.gitconfig.local` for personal info
- Template available: `.gitconfig.template`

**Required Manual Setup:**
Users must create `~/.gitconfig.local` with:
```ini
[user]
    name = Your Name
    email = your.email@example.com
```

### Claude Code Configuration

The repository includes a status checker for Claude Code:

```bash
~/.init/claude.sh
```

This script shows:
- Whether `.claude.json` exists (runtime state, not synced)
- Installed skills in `~/.claude/skills/`
- MCP server configuration status
- Status of tracked dotfiles

**Important**: `.claude.json` is intentionally not tracked as it contains:
- Usage statistics and session IDs
- Organization/user identifiers
- Runtime feature flags that change frequently

If you need to sync Claude Code preferences, focus on:
- Custom skills in `~/.claude/skills/`
- MCP server configurations in `~/.claude/mcp.json`
- Project-specific `.claude/` directories in repositories

### Post-Installation Requirements

Terminal applications need "Full Disk Access" permission in macOS for certain features to work correctly:
- **System Settings → Privacy & Security → Full Disk Access**
- Add your terminal app (Ghostty, iTerm2, Terminal.app, etc.)

## Troubleshooting

### `config` alias not found

The alias may not be loaded. Try:
```bash
source ~/.zshrc
```

Or check if it's defined:
```bash
alias config
```

### Changes not appearing in `config status`

Only tracked files appear. To track a new file:
```bash
config add <filename>
```

### fnm command not found

Ensure fnm is installed and shell configuration is loaded:
```bash
brew install fnm
source ~/.zshrc
fnm --version
```

### pnpm not found

Run the node setup script:
```bash
~/.init/node.sh
```

Or install manually:
```bash
curl -fsSL https://get.pnpm.io/install.sh | sh -
source ~/.zshrc
```

### Ghostty themes not loading

Ensure themes are in the correct location:
```bash
ls ~/.config/ghostty/themes/
```

Theme files should have `.conf` extension.

### Understanding the Bare Repository

If you're confused by the bare repository approach:

**What's happening:**
- Your actual dotfiles live in `$HOME` (e.g., `~/.zshrc`)
- The Git repository database is at `~/.dotfiles/`
- The `config` alias points Git to use `$HOME` as the working tree

**This means:**
- ✓ Use `config` commands from anywhere in `$HOME`
- ✓ Edit files in their normal locations (`~/.zshrc`, not in a repo clone)
- ✗ Don't use `git` commands (use `config` instead)
- ✗ Don't expect to see a `.git` folder in `$HOME`

**Quick reference:**
```bash
# See what dotfiles are tracked
config ls-files

# See status of tracked files only
config status

# Add a new dotfile
config add ~/.newconfig

# Commit changes
config commit -m "message"
```

## Modern Tool Commands

### pnpm Package Manager
```bash
pn                    # pnpm
pni                   # pnpm install
pnr dev              # pnpm run dev
pnx eslint .         # pnpm exec eslint .
```

### fnm Node Manager
```bash
fnm list             # List installed versions
fnm install 20       # Install Node 20
fnm use 20           # Use Node 20
fnm default 20       # Set default Node version
```

### Git Worktrees
```bash
gwl                  # List worktrees
gwa feature-branch   # Add worktree for branch
gwr feature-branch   # Remove worktree
```

### System Maintenance
```bash
update               # Update Homebrew and cleanup
~/.init/claude.sh    # Check Claude Code status
source ~/.zshrc      # Reload shell configuration
```

## Important Notes

- This repository assumes **macOS** as the operating system
- The installation process requires **Git** and **curl** to be pre-installed
- **Xcode Command Line Tools** are installed during the bootstrap process
- The bare repository approach means standard Git commands won't work - **always use the `config` alias**
- **macOS system preferences** are not automated - see README.md for manual setup commands
- **fnm** and **pnpm** replace older npm-based workflows
- **Ghostty** is the preferred modern terminal emulator
- **.claude.json** should never be tracked (runtime state file)
