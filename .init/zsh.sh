#!/usr/bin/env bash

MEDIUMORCHID='\033[38;5;207m'
GREY='\033[38;5;240m'
NC='\033[0m' # No Color

# Install oh my zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
chsh -s $(which zsh)

# Install powerlevel10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k