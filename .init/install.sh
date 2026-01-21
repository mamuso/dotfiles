#!/usr/bin/env bash

set -e  # Exit on error

MEDIUMORCHID='\033[38;5;207m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

echo ""
echo -e "${MEDIUMORCHID}==> Installing dotfiles${NC}"
echo ""

# Check if git is installed
if ! command -v git &> /dev/null; then
    echo -e "${RED}✗ Git is not installed${NC}"
    echo "  Please install Xcode Command Line Tools first:"
    echo "  xcode-select --install"
    exit 1
fi

# Check if dotfiles are already installed
if [ -d "$HOME/.dotfiles" ]; then
    echo -e "${YELLOW}! .dotfiles directory already exists${NC}"
    while true; do
        echo -ne "  Do you want to reinstall? This will backup the existing installation. (y/N) → "
        read -p "" yn && yn="${yn:-n}"
        case $yn in
            [Yy]* )
                TIMESTAMP=$(date +%Y%m%d_%H%M%S)
                mv "$HOME/.dotfiles" "$HOME/.dotfiles.backup.$TIMESTAMP"
                echo -e "${GREEN}✓${NC} Backed up to ~/.dotfiles.backup.$TIMESTAMP"
                break;;
            [Nn]* )
                echo "Installation cancelled"
                exit 0;;
            * ) echo "Please answer yes or no.";;
        esac
    done
fi

# Clone the dotfiles repository as bare repo
echo -e "${MEDIUMORCHID}→${NC} Cloning dotfiles repository..."
if ! git clone --bare git@github.com:mamuso/dotfiles.git "$HOME/.dotfiles"; then
    echo -e "${RED}✗ Failed to clone repository${NC}"
    echo "  Make sure you have SSH access to the repository"
    echo "  Or update the URL in .init/install.sh to use HTTPS"
    exit 1
fi

echo -e "${GREEN}✓${NC} Repository cloned"

# Define config function for this session
function config {
   /usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME $@
}

# Create backup directory with timestamp
BACKUP_DIR="$HOME/.dotfiles-backup"
if [ -d "$BACKUP_DIR" ]; then
    TIMESTAMP=$(date +%Y%m%d_%H%M%S)
    BACKUP_DIR="$HOME/.dotfiles-backup-$TIMESTAMP"
fi
mkdir -p "$BACKUP_DIR"

echo ""
echo -e "${MEDIUMORCHID}→${NC} Checking out dotfiles..."

# Try to checkout
if config checkout 2>&1 | tee /tmp/dotfiles-checkout.log; then
    echo -e "${GREEN}✓${NC} Dotfiles checked out successfully"
else
    echo ""
    echo -e "${YELLOW}! Some files already exist${NC}"
    echo "  Backing up existing files to $BACKUP_DIR"
    echo ""

    # Parse conflicting files and back them up
    grep -E "^\s+\." /tmp/dotfiles-checkout.log | awk '{print $1}' | while read file; do
        # Create directory structure in backup
        mkdir -p "$BACKUP_DIR/$(dirname "$file")"
        # Move file to backup
        mv "$HOME/$file" "$BACKUP_DIR/$file" 2>/dev/null || true
        echo -e "${GREEN}  ✓${NC} Backed up: $file"
    done

    echo ""
    echo -e "${MEDIUMORCHID}→${NC} Retrying checkout..."

    if config checkout; then
        echo -e "${GREEN}✓${NC} Dotfiles checked out successfully"
    else
        echo -e "${RED}✗ Failed to checkout dotfiles${NC}"
        echo "  Please check the conflicts manually"
        exit 1
    fi
fi

# Configure git to not show untracked files
config config status.showUntrackedFiles no
echo -e "${GREEN}✓${NC} Configured dotfiles repository"

echo ""
echo -e "${GREEN}==> Dotfiles installation complete!${NC}"
echo ""
echo "Next steps:"
echo "  1. Review backed up files (if any) in: $BACKUP_DIR"
echo "  2. Run the bootstrap script: ~/.init/bootstrap.sh"
echo "  3. Restart your terminal or run: source ~/.zshrc"
echo ""
echo "To manage your dotfiles, use the 'config' alias:"
echo "  config status"
echo "  config add <file>"
echo "  config commit -m \"message\""
echo "  config push"
echo ""

# Clean up temp file
rm -f /tmp/dotfiles-checkout.log
