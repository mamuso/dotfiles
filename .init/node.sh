#!/usr/bin/env bash

MEDIUMORCHID='\033[38;5;207m'
GREY='\033[38;5;240m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo ""
echo -e "${MEDIUMORCHID}==> Node.js Setup (fnm + pnpm)${NC}"
echo ""

# Install fnm (Fast Node Manager)
echo -e "${MEDIUMORCHID}→${NC} Installing fnm (Fast Node Manager)"
brew install fnm

# Ensure brew environment is loaded
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

# Initialize fnm for this session
if command -v fnm &> /dev/null; then
  eval "$(fnm env --use-on-cd)"
  echo -e "${GREEN}✓${NC} fnm installed and initialized"
else
  echo -e "${MEDIUMORCHID}!${NC} Warning: fnm not found in PATH after installation"
  echo "  You may need to restart your terminal"
  exit 1
fi

# Install latest LTS node
echo ""
echo -e "${MEDIUMORCHID}→${NC} Installing Node.js LTS"
fnm install --lts
fnm use lts-latest
fnm default lts-latest

# Verify node installation
if command -v node &> /dev/null; then
  NODE_VERSION=$(node --version)
  echo -e "${GREEN}✓${NC} Node.js $NODE_VERSION installed"
else
  echo -e "${MEDIUMORCHID}!${NC} Warning: Node.js not found after installation"
fi

# Install pnpm
echo ""
echo -e "${MEDIUMORCHID}→${NC} Installing pnpm"
curl -fsSL https://get.pnpm.io/install.sh | sh -

# Verify pnpm installation
export PNPM_HOME="$HOME/Library/pnpm"
export PATH="$PNPM_HOME:$PATH"

if command -v pnpm &> /dev/null; then
  PNPM_VERSION=$(pnpm --version)
  echo -e "${GREEN}✓${NC} pnpm $PNPM_VERSION installed"
else
  echo -e "${MEDIUMORCHID}!${NC} pnpm installed but not yet in PATH"
  echo "  Run: source ~/.zshrc"
fi

echo ""
echo -e "${GREEN}==> Node.js setup complete${NC}"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal or run: source ~/.zshrc"
echo "  2. Verify installation: node --version && pnpm --version"
echo ""
