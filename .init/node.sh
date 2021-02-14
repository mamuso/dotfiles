#!/usr/bin/env bash

MEDIUMORCHID='\033[38;5;207m'
GREY='\033[38;5;240m'
NC='\033[0m' # No Color

# Change default npm home directory
# https://docs.npmjs.com/resolving-eacces-permissions-errors-when-installing-packages-globally
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'

# Update the npm cli
npm install -g npm@latest

# Pure theme for zsh
npm install --g pure-prompt
ln -s ~/.npm-global/lib/node_modules/pure-prompt/ ~/.zsh/pure