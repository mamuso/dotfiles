#!/usr/bin/env bash

MEDIUMORCHID="\033[38;5;207m"
NC='\033[0m' # No Color

# Install brew
echo -e "${MEDIUMORCHID}==>${NC} Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Install brew packages
echo -e "${MEDIUMORCHID}==>${NC} Installing brew packages"

# Make sure we’re using the latest Homebrew.
# Upgrade any already-installed formulae.
brew update
brew upgrade

# Save Homebrew’s installed location.
BREW_PREFIX=$(brew --prefix)

# Install GNU core utilities (those that come with macOS are outdated).
# Don’t forget to add `$(brew --prefix coreutils)/libexec/gnubin` to `$PATH`.
brew install coreutils
ln -s "${BREW_PREFIX}/bin/gsha256sum" "${BREW_PREFIX}/bin/sha256sum"

# Install some other useful utilities like `sponge`.
brew install moreutils
# Install GNU `find`, `locate`, `updatedb`, and `xargs`, `g`-prefixed.
brew install findutils
# Install GNU `sed`, overwriting the built-in `sed`.
brew install gnu-sed
# Install GitHub CLI
brew install gh
# Install node
brew install node
# Install McFly
brew tap cantino/mcfly https://github.com/cantino/mcfly
brew install mcfly

# Install rbenv
brew install rbenv
rbenv init
#rbenv install 2.7.2

# Install fonts
brew install font-jetbrains-mono font-mona-sans font-monaspace font-inter font-geist
