#!/usr/bin/env bash

BASEDIR=$(dirname "$0")

PURPLE='\033[0;35m'
GREY='\033[38;5;240m'
NC='\033[0m' # No Color

# macOS defaults
while true; do
  echo -ne "${PURPLE}Do you wish to set up your custom macOS defaults?${GREY} (Y/n) → ${NC}"
  read -p "" yn && yn="${yn:-y}"
    case $yn in
        [Yy]* ) $BASEDIR/macos.sh; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Xcode Select
while true; do
  echo -ne "${PURPLE}Do you wish to install Xcode Command Line Tools?${GREY} (Y/n) → ${NC}"
  read -p "" yn && yn="${yn:-y}"
    case $yn in
        [Yy]* ) xcode-select --install; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Git
while true; do
  echo -ne "${PURPLE}Do you wish to set up git?${GREY} (Y/n) → ${NC}"
  read -p "" yn && yn="${yn:-y}"
    case $yn in
        [Yy]* ) $BASEDIR/git.sh; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done

# Brew
while true; do
  echo -ne "${PURPLE}Do you wish to install brew?${GREY} (Y/n) → ${NC}"
  read -p "" yn && yn="${yn:-y}"
    case $yn in
        [Yy]* ) $BASEDIR/brew.sh; break;;
        [Nn]* ) break;;
        * ) echo "Please answer yes or no.";;
    esac
done
