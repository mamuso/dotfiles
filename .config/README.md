# .config Directory

This directory contains modern tool configurations that follow the XDG Base Directory specification.

## Tracked Configurations

### GitHub CLI (`gh/`)

**Location**: `.config/gh/config.yml`

Configuration for the GitHub CLI tool (`gh`), including:
- Git protocol preference (https/ssh)
- Editor settings
- Custom aliases
- Pager configuration

**Setup**:
```bash
# Authenticate with GitHub
gh auth login

# Verify configuration
gh config list
```

**Custom Aliases**:
- `co` → `pr checkout` (checkout pull request branch)

**Documentation**: [GitHub CLI Manual](https://cli.github.com/manual/)

---

### Ghostty Terminal (`ghostty/`)

**Location**: `.config/ghostty/themes/`

Theme files for [Ghostty](https://ghostty.org/), a modern GPU-accelerated terminal emulator.

**Included Themes**:
- `catppuccin-frappe.conf` - Catppuccin Frappé (warm, dark)
- `catppuccin-latte.conf` - Catppuccin Latte (light)
- `catppuccin-macchiato.conf` - Catppuccin Macchiato (dark)
- `catppuccin-mocha.conf` - Catppuccin Mocha (darkest)
- `vercel.conf` - Custom Vercel-inspired theme

**Usage**:
Ghostty automatically detects themes in `~/.config/ghostty/themes/`. To use a theme:

1. Create or edit `~/.config/ghostty/config`:
   ```
   theme = vercel
   ```

2. Or use the Ghostty settings UI to select a theme

**Documentation**: [Ghostty Themes](https://ghostty.org/docs/config/appearance#theme)

---

### Karabiner Elements (`karabiner/`)

**Location**: `.config/karabiner/karabiner.json`

Configuration for [Karabiner-Elements](https://karabiner-elements.pqrs.org/), a powerful keyboard customization tool for macOS.

**Features**:
- Custom key mappings
- Complex modifications
- Device-specific rules
- Application-specific shortcuts

**Setup**:
1. Install Karabiner-Elements:
   ```bash
   brew install --cask karabiner-elements
   ```

2. Grant necessary permissions in System Settings:
   - Privacy & Security → Input Monitoring
   - Privacy & Security → Accessibility

3. The configuration will be automatically loaded from this location

**Editing**:
- Use the Karabiner-Elements UI for most changes
- Manual JSON editing for advanced modifications
- Backup before major changes

**Documentation**: [Karabiner-Elements Documentation](https://karabiner-elements.pqrs.org/docs/)

---

## Not Tracked

The following `.config` directories are **not tracked** in this dotfiles repository:

### Application Caches
- `.config/1Password/` - Sensitive credential data
- `.config/configstore/` - npm package caches

### IDE/Editor State
- `.config/Code/` - VS Code (use Settings Sync instead)
- `.config/cursor/` - Cursor editor

### System State
- `.config/spotify/` - Spotify cache
- `.config/slack/` - Slack data

These directories contain either:
- Sensitive information (credentials, tokens)
- Large cache files
- Machine-specific state
- Data better managed by the application itself

## Adding New Configurations

To track a new configuration directory:

1. **Add to this repository**:
   ```bash
   cd ~/Code/dotfiles
   mkdir -p .config/toolname
   cp ~/.config/toolname/config .config/toolname/
   git add .config/toolname/
   git commit -m "Add toolname configuration"
   ```

2. **Update this README**:
   - Add a new section describing the tool
   - Document what's configured
   - Include setup instructions
   - Link to official documentation

3. **Create installation script** (if needed):
   - Add setup logic to `.init/bootstrap.sh`
   - Or create a new script in `.init/`

## Syncing to Home Directory

When you clone this dotfiles repository, the installation script (`.init/install.sh`) will:

1. Create symlinks from `~/.config/` to the dotfiles repo
2. Preserve existing configurations (backup created)
3. Allow bidirectional sync via the bare repository

To manually sync a config:
```bash
# Using the config alias (bare repo approach)
config add ~/.config/toolname/config
config commit -m "Update toolname config"
config push
```

## Tool Selection Criteria

Configurations are tracked in this repository if they:

✓ Are **portable** across machines
✓ Contain **no sensitive data**
✓ Are **relatively stable** (not constantly changing)
✓ Benefit from **version control**
✓ Are **meaningful to share** with others

Configurations are **not tracked** if they:

✗ Contain credentials or tokens
✗ Are machine-specific
✗ Are primarily cache/state files
✗ Are better managed by the tool itself
✗ Change too frequently to track

## Resources

- [XDG Base Directory Specification](https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html)
- [Arch Linux XDG Base Directory Support](https://wiki.archlinux.org/title/XDG_Base_Directory)
- [dotfiles.github.io](https://dotfiles.github.io/) - Dotfiles guide and examples
