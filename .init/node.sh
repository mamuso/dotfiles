#!/usr/bin/env bash

MEDIUMORCHID='\033[38;5;207m'
GREY='\033[38;5;240m'
NC='\033[0m' # No Color

# Install fnm (Fast Node Manager)
echo -e "${MEDIUMORCHID}==>${NC} Installing fnm (Fast Node Manager)"
brew install fnm

# Install latest LTS node
echo -e "${MEDIUMORCHID}==>${NC} Installing Node.js LTS"
eval "$(fnm env --use-on-cd)"
fnm install --lts
fnm use lts-latest
fnm default lts-latest

# Install pnpm
echo -e "${MEDIUMORCHID}==>${NC} Installing pnpm"
curl -fsSL https://get.pnpm.io/install.sh | sh -
