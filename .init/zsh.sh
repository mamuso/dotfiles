#!/usr/bin/env bash

MEDIUMORCHID='\033[38;5;207m'
GREY='\033[38;5;240m'
NC='\033[0m' # No Color

sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fpath+=('/Users/mamuso/.npm-global/lib/node_modules/pure-prompt/functions')
chsh -s $(which zsh)
